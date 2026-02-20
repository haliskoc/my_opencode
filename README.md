# OpenCode Super Assistant

## Türkçe

### Nedir?

OpenCode CLI üzerine kurulu süper profil eklentisi. Tek komutla kurulur, OpenCode'u zengin agent, skill, komut ve plugin seti ile güçlendirir:

- `oh-my-opencode` plugin aktif
- **6 Primary agent**: `full`, `sisyphus`, `atlas`, `hephaestus`, `plan`, `safe`
- **20 Subagent**: `prometheus`, `oracle`, `librarian`, `explore`, `metis`, `momus`, `multimodal-looker`, `frontend`, `backend`, `devops`, `reviewer`, `tester`, `security`, `docs`, `release`, `incident`, `quick`, `deep`, `visual-engineering`, `writing`
- **46 Skill**: prompt-engineer, ai-integration, data-modeling, caching-strategy, kubernetes-deploy, load-testing, animation-motion, state-management, ve daha fazlası
- **36 Komut**: `/diagram`, `/explain`, `/diff-review`, `/ship`, `/refactor`, `/ulw`, `/benchmark`, `/changelog`, ve daha fazlası
- **4 Sektör profili**: `profile-saas`, `profile-ecommerce`, `profile-fintech`, `profile-game-backend`
- **3 MCP sunucusu**: `context7`, `gh_grep`, `websearch`
- Semver otomasyonu: `release-please` + `CHANGELOG.md`

### Tek komut kurulum

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash
```

Bu komut:
- OpenCode CLI'ı kontrol eder (yoksa npm ile kurar)
- Mevcut profili algılar (varsa sıfırlar ve yedekler)
- 46 skill, 36 komut, 26 agent içeren süper profili kurar
- oh-my-opencode plugin'ini aktifleştirir

### Sabit sürüm kurulumu

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/v1.0.0/install.sh | bash -s -- --ref v1.0.0
```

### Kurulumdan sonra

```bash
opencode
```

### Kurulum seçenekleri

```bash
# Mevcut profili zorla sıfırla
./install.sh --reset

# Sıfırlama yapmadan güncelle
./install.sh --no-reset

# Yerel dizinden kur
./install.sh --source /path/to/my_opencode

# Sadece profil kur (OpenCode CLI kurulumunu atla)
./install.sh --skip-opencode
```

### Doğrulama

OpenCode içinde:

```
/doctor     → Sağlık kontrolü
/agents     → Agent listesi
/skills     → Skill listesi
/profiles   → Sektör profilleri
```

Shell'den:

```bash
opencode mcp list
```

Beklenen: `context7`, `gh_grep`, `websearch`

### API key'leri (opsiyonel)

```bash
export OPENAI_API_KEY="your_key"
export ANTHROPIC_API_KEY="your_key"
export GOOGLE_API_KEY="your_key"
export CONTEXT7_API_KEY="your_key"
export EXA_API_KEY="your_key"
opencode
```

---

## English

### What is this?

A super profile extension for OpenCode CLI. One-command install that powers up OpenCode with a rich set of agents, skills, commands, and plugins:

- `oh-my-opencode` plugin enabled
- **6 Primary agents**: `full`, `sisyphus`, `atlas`, `hephaestus`, `plan`, `safe`
- **20 Subagents**: `prometheus`, `oracle`, `librarian`, `explore`, `metis`, `momus`, `multimodal-looker`, `frontend`, `backend`, `devops`, `reviewer`, `tester`, `security`, `docs`, `release`, `incident`, `quick`, `deep`, `visual-engineering`, `writing`
- **46 Skills**: prompt-engineer, ai-integration, data-modeling, caching-strategy, kubernetes-deploy, load-testing, animation-motion, state-management, and more
- **36 Commands**: `/diagram`, `/explain`, `/diff-review`, `/ship`, `/refactor`, `/ulw`, `/benchmark`, `/changelog`, and more
- **4 Industry profiles**: `profile-saas`, `profile-ecommerce`, `profile-fintech`, `profile-game-backend`
- **3 MCP servers**: `context7`, `gh_grep`, `websearch`
- Semver automation: `release-please` + `CHANGELOG.md`

### One-command install

```bash
curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash
```

This command will:
- Check for OpenCode CLI (installs via npm if missing)
- Detect existing profile (resets and backs up if found)
- Install the super profile with 46 skills, 36 commands, 26 agents
- Enable the oh-my-opencode plugin

### After installation

```bash
opencode
```

### Install options

```bash
# Force reset existing profile
./install.sh --reset

# Upgrade without reset
./install.sh --no-reset

# Install from local directory
./install.sh --source /path/to/my_opencode

# Profile only (skip OpenCode CLI install)
./install.sh --skip-opencode
```

### Verify

Inside OpenCode:

```
/doctor     → Health check
/agents     → List agents
/skills     → List skills
/profiles   → Industry profiles
```

From shell:

```bash
opencode mcp list
```

Expected: `context7`, `gh_grep`, `websearch`

### Optional provider keys

```bash
export OPENAI_API_KEY="your_key"
export ANTHROPIC_API_KEY="your_key"
export GOOGLE_API_KEY="your_key"
export CONTEXT7_API_KEY="your_key"
export EXA_API_KEY="your_key"
opencode
```
