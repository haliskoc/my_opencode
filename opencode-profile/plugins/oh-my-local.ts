import type { Plugin } from "@opencode-ai/plugin"

const BLOCKED_ENV_SUFFIXES = [
  "/.env",
  "/.env.local",
  "/.env.production",
  "/.env.development",
]

function normalizePath(value: string): string {
  return value.replace(/\\/g, "/").toLowerCase()
}

function isBlockedEnvRead(filePath: string): boolean {
  const normalized = normalizePath(filePath)
  return BLOCKED_ENV_SUFFIXES.some((suffix) => normalized.endsWith(suffix))
}

function isDangerousGitCommand(command: string): boolean {
  const normalized = command.toLowerCase()
  return (
    normalized.includes("git push --force") ||
    normalized.includes("git push -f") ||
    normalized.includes("git reset --hard")
  )
}

function extractPatchText(args: Record<string, unknown>): string {
  for (const key of ["patch", "patchText", "content", "newText", "newContent"]) {
    const value = args[key]
    if (typeof value === "string") return value
  }
  return ""
}

function countNewCommentLines(text: string): number {
  if (!text) return 0
  const lines = text.split("\n")
  let count = 0
  for (const line of lines) {
    const trimmed = line.trim()
    if (trimmed.startsWith("+")) {
      const body = trimmed.slice(1).trim()
      if (body.startsWith("//") || body.startsWith("/*") || body.startsWith("*") || body.startsWith("#")) {
        count += 1
      }
    }
  }
  return count
}

function isCodeFile(filePath: string): boolean {
  const normalized = normalizePath(filePath)
  return [".ts", ".tsx", ".js", ".jsx", ".py", ".go", ".java", ".rb", ".rs", ".c", ".cc", ".cpp"].some((ext) => normalized.endsWith(ext))
}

export const OhMyLocalPlugin: Plugin = async ({ $, client }) => {
  let pendingTodos = 0

  await client.app.log({
    body: {
      service: "oh-my-local",
      level: "info",
      message: "Plugin initialized",
    },
  })

  return {
    "tool.execute.before": async (input, output) => {
      if (
        input.tool === "read" &&
        typeof output.args.filePath === "string" &&
        isBlockedEnvRead(output.args.filePath)
      ) {
        throw new Error("Blocked: reading .env files is disabled by profile policy")
      }

      if (
        input.tool === "bash" &&
        typeof output.args.command === "string" &&
        isDangerousGitCommand(output.args.command)
      ) {
        throw new Error("Blocked: dangerous git command detected")
      }

      if (input.tool === "edit" || input.tool === "write") {
        const filePath = (output.args as Record<string, unknown>).filePath
        if (typeof filePath !== "string" || !isCodeFile(filePath)) return

        const patchText = extractPatchText(output.args as Record<string, unknown>)
        const newComments = countNewCommentLines(patchText)
        if (newComments > 12) {
          throw new Error("Blocked: too many new comment lines in a single change. Keep comments minimal.")
        }
      }
    },

    "shell.env": async (_input, output) => {
      output.env.OPENCODE_PROFILE = "super-assistant"
    },

    event: async ({ event }) => {
      if (event.type === "todo.updated") {
        const maybeTodos = (event as unknown as { properties?: { todos?: Array<{ status?: string }> } }).properties?.todos
        if (Array.isArray(maybeTodos)) {
          pendingTodos = maybeTodos.filter((todo) => todo?.status && todo.status !== "completed" && todo.status !== "cancelled").length
        }
        return
      }

      if (event.type !== "session.idle" && event.type !== "session.error") return

      const message =
        event.type === "session.error"
          ? "OpenCode session error"
          : pendingTodos > 0
            ? `OpenCode response ready (${pendingTodos} todo pending)`
            : "OpenCode response is ready"

      try {
        await $`which notify-send`
        await $`notify-send OpenCode ${message}`
      } catch {
      }
    },
  }
}
