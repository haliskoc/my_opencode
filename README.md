# OpenCode Super Assistant Docker

This image ships OpenCode with a preloaded profile:

- NPM plugin enabled: `oh-my-opencode`
- Core primary agents: `full`, `sisyphus`, `atlas`, `hephaestus`, `plan`, `safe`
- Specialized subagents: `prometheus`, `oracle`, `librarian`, `explore`, `metis`, `momus`, `multimodal-looker`, `frontend`, `backend`, `devops`, `reviewer`, `tester`, `security`, `docs`, `release`, `incident`
- Category subagents: `quick`, `deep`, `visual-engineering`, `writing`
- Default MCP servers: `context7`, `gh_grep`, `websearch`
- Skill library: popular engineering skills + extracted oh-my style skills (`git-master`, `playwright`, `frontend-ui-ux`, `agent-browser`, `dev-browser`)
- Industry profile skills: `profile-saas`, `profile-ecommerce`, `profile-fintech`, `profile-game-backend`
- Custom commands: `/agents`, `/skills`, `/profiles`, `/use-profile <name>`, `/quick`, `/deep`, `/visual`, `/writing`, `/ulw`, `/init-deep`, `/ralph-loop`, `/ulw-loop`, `/cancel-ralph`, `/refactor`, `/start-work`, `/stop-continuation`, `/categories`, `/route-task`
- Clipboard image helper: `opencode-clipimg` + `/clip-image`
- Reference source included in image: `/opt/oh-my-opencode-source`

## Build

```bash
docker build -t opencode-super .
```

## One-command install

If users already cloned this repo:

```bash
./install.sh
```

Direct one-command install from this repository:

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash -s -- --repo https://github.com/haliskoc/my_opencode.git
```

Step-by-step:

1. Run the install command above.
2. Open a new terminal (or run `export PATH="$HOME/.local/bin:$PATH"`).
3. Start with `opencode-super`.

After install, launch with:

```bash
opencode-super
```

## Run

```bash
docker run -it --rm \
  -v "$(pwd)":/workspace \
  opencode-super
```

## Run with Docker Compose

```bash
docker compose up --build opencode
```

## Optional persistent auth and history

```bash
docker run -it --rm \
  -v "$(pwd)":/workspace \
  -v "$HOME/.local/share/opencode":/root/.local/share/opencode \
  opencode-super
```

## Optional provider keys

```bash
docker run -it --rm \
  -v "$(pwd)":/workspace \
  -e OPENAI_API_KEY="your_key" \
  -e CONTEXT7_API_KEY="your_key" \
  -e EXA_API_KEY="your_key" \
  opencode-super
```

## Verify profile inside container

Run these in OpenCode:

- `/agents`
- `/skills`

And from shell:

```bash
opencode mcp list
```

## Expected defaults

- Primary agent tabs include `full`, `plan`, and `safe`
- `/agents` lists extended subagents including `oracle`, `librarian`, `metis`, `momus`, and `multimodal-looker`
- `/skills` lists the extended skill catalog
- `/profiles` lists industry personas
- `/use-profile profile-saas` applies a persona to current task style
- `/ulw` triggers ultrawork-style orchestration with todo-first completion discipline
- `/clip-image` saves clipboard image and injects file path into context
- `opencode mcp list` shows `context7`, `gh_grep`, and `websearch`
