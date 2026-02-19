# OpenCode Super Assistant Docker

## Turkish

### Nedir?

Bu repo, OpenCode'u Docker icinde hazir profil ile calistirir:

- `oh-my-opencode` plugin aktif
- Primary agentler: `full`, `sisyphus`, `atlas`, `hephaestus`, `plan`, `safe`
- Zengin subagent seti: `prometheus`, `oracle`, `librarian`, `explore`, `metis`, `momus`, `multimodal-looker`, `frontend`, `backend`, `devops`, `reviewer`, `tester`, `security`, `docs`, `release`, `incident`
- Kategori ajanlari: `quick`, `deep`, `visual-engineering`, `writing`
- MCP varsayilanlari: `context7`, `gh_grep`, `websearch`
- Skill kutuphanesi + sektor profilleri (`profile-saas`, `profile-ecommerce`, `profile-fintech`, `profile-game-backend`)
- Ozel komutlar: `/ulw`, `/refactor`, `/route-task`, `/profiles`, `/clip-image`, `/doctor`, `/ship` ve daha fazlasi
- CI/CD ve guvenlik workflow'lari: `.github/workflows/`
- Surum dosyasi: `VERSION` (deterministik image etiketi icin)
- Semver otomasyonu: `release-please` + `CHANGELOG.md`

### Tek komut kurulum (dosya indirmeden)

Asagidaki komut tek seferde:

- repoyu alir
- Docker yoksa (Ubuntu/Debian) kurar
- hostta `opencode` yoksa npm ile kurmayi dener
- image build eder
- `opencode-super` launcher olusturur

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash
```

Sabit surum (onerilen):

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/v1.0.0/install.sh | bash -s -- --ref v1.0.0 --version 1.0.0
```

Kurulumdan sonra:

```bash
opencode-super
```

Ek launcher komutlari:

```bash
opencode-super --version
opencode-super --self-update
```

Not: Varsayilan guvenlik modu hardened calisir (`read-only`, `cap-drop`, `no-new-privileges`).
Gecici kapatmak icin:

```bash
OPENCODE_SUPER_UNSAFE=1 opencode-super
```

Eger komut bulunamazsa:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Opsiyonel API key gecisi

```bash
export OPENAI_API_KEY="your_key"
export CONTEXT7_API_KEY="your_key"
export EXA_API_KEY="your_key"
opencode-super
```

### Dogrulama

OpenCode icinde:

- `/agents`
- `/skills`
- `/profiles`

Shell icinde:

```bash
opencode mcp list
```

Beklenen: `context7`, `gh_grep`, `websearch`

---

## English

### What is this?

This repo runs OpenCode inside Docker with a preloaded super profile:

- `oh-my-opencode` plugin enabled
- Primary agents: `full`, `sisyphus`, `atlas`, `hephaestus`, `plan`, `safe`
- Rich subagent set: `prometheus`, `oracle`, `librarian`, `explore`, `metis`, `momus`, `multimodal-looker`, `frontend`, `backend`, `devops`, `reviewer`, `tester`, `security`, `docs`, `release`, `incident`
- Category agents: `quick`, `deep`, `visual-engineering`, `writing`
- Default MCP servers: `context7`, `gh_grep`, `websearch`
- Skill library + industry profiles (`profile-saas`, `profile-ecommerce`, `profile-fintech`, `profile-game-backend`)
- Custom commands: `/ulw`, `/refactor`, `/route-task`, `/profiles`, `/clip-image`, `/doctor`, `/ship`, and more
- CI/CD and security workflows: `.github/workflows/`
- Version file: `VERSION` (for deterministic image tags)
- Semver automation: `release-please` + `CHANGELOG.md`

### One-command install (no manual file download)

This command will:

- clone the repo
- install Docker automatically on Ubuntu/Debian if missing
- attempt host `opencode` install via npm if missing
- build the Docker image
- create the `opencode-super` launcher

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash
```

Pinned version (recommended):

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/v1.0.0/install.sh | bash -s -- --ref v1.0.0 --version 1.0.0
```

Then run:

```bash
opencode-super
```

Launcher extras:

```bash
opencode-super --version
opencode-super --self-update
```

Note: Hardened runtime is enabled by default (`read-only`, `cap-drop`, `no-new-privileges`).
To temporarily disable:

```bash
OPENCODE_SUPER_UNSAFE=1 opencode-super
```

If command is not found:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

### Optional provider keys

```bash
export OPENAI_API_KEY="your_key"
export CONTEXT7_API_KEY="your_key"
export EXA_API_KEY="your_key"
opencode-super
```

### Verify

Inside OpenCode:

- `/agents`
- `/skills`
- `/profiles`

From shell:

```bash
opencode mcp list
```

Expected MCPs: `context7`, `gh_grep`, `websearch`
