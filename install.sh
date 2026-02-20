#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# OpenCode Super Assistant — Profile Installer
# ============================================================================
# This script:
#   1. Checks if OpenCode CLI is installed
#   2. If installed → resets profile to clean state (backup first)
#   3. If not installed → installs OpenCode CLI via npm
#   4. Copies the super profile (skills, commands, agents, plugins) into
#      ~/.config/opencode/
#   5. Installs profile npm dependencies (oh-my-opencode, plugin SDK)
#
# One-line install:
#   curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash
# ============================================================================

REPO_URL_DEFAULT="https://github.com/haliskoc/my_opencode.git"
INSTALL_REF="main"
OPENCODE_CONFIG_DIR="${HOME}/.config/opencode"
OPENCODE_DATA_DIR="${HOME}/.local/share/opencode"
OPENCODE_STATE_DIR="${HOME}/.local/state/opencode"
WORK_DIR=""

SOURCE_DIR=""
REPO_URL="${REPO_URL_DEFAULT}"
FORCE_RESET="false"
SKIP_RESET="false"
SKIP_OPENCODE_INSTALL="false"
LOG_FILE=""

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log() {
  printf "${GREEN}[✓]${NC} %s\n" "$*"
}

info() {
  printf "${BLUE}[i]${NC} %s\n" "$*"
}

warn() {
  printf "${YELLOW}[!]${NC} %s\n" "$*" >&2
}

die() {
  printf "${RED}[✗]${NC} %s\n" "$*" >&2
  if [[ -n "${LOG_FILE}" ]]; then
    printf "${RED}[✗]${NC} Log file: %s\n" "${LOG_FILE}" >&2
  fi
  # Clean up temp dir
  if [[ -n "${WORK_DIR}" && -d "${WORK_DIR}" ]]; then
    rm -rf "${WORK_DIR}"
  fi
  exit 1
}

header() {
  printf "\n${BOLD}${CYAN}━━━ %s ━━━${NC}\n\n" "$*"
}

usage() {
  cat <<EOF
${BOLD}OpenCode Super Assistant — Profile Installer${NC}

Usage:
  ./install.sh [options]
  curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash

Options:
  --source <path>         Local directory containing opencode-profile
  --repo <url>            Repository URL to clone (default: ${REPO_URL_DEFAULT})
  --ref <git-ref>         Git branch/tag/commit to install from (default: main)
  --reset                 Force reset existing profile before install
  --no-reset              Skip reset even if existing profile detected
  --skip-opencode         Do not install OpenCode CLI (profile only)
  -h, --help              Show this help

What it does:
  1. Detects existing OpenCode installation
  2. Resets profile if found (backs up first) or installs fresh
  3. Installs OpenCode CLI via npm if not found
  4. Copies super profile with 46 skills, 36 commands, 26 agents
  5. Installs profile dependencies (oh-my-opencode plugin)

Examples:
  ./install.sh
  ./install.sh --reset
  ./install.sh --source /path/to/my_opencode
  curl -fsSL https://raw.githubusercontent.com/haliskoc/my_opencode/main/install.sh | bash
EOF
}

# ============================================================================
# Utility
# ============================================================================

have_sudo() {
  command -v sudo >/dev/null 2>&1
}

run_as_root() {
  if [[ "${EUID}" -eq 0 ]]; then
    "$@"
    return
  fi
  if have_sudo; then
    sudo "$@"
    return
  fi
  die "This step needs root privileges. Install sudo or run as root."
}

is_debian_family() {
  [[ -f /etc/debian_version ]]
}

setup_logging() {
  mkdir -p "${HOME}/.local/share/opencode-super/logs"
  LOG_FILE="${HOME}/.local/share/opencode-super/logs/install-$(date +%Y%m%d-%H%M%S).log"
  exec > >(tee -a "${LOG_FILE}") 2>&1
  trap 'die "Installation failed."' ERR
}

cleanup() {
  if [[ -n "${WORK_DIR}" && -d "${WORK_DIR}" ]]; then
    rm -rf "${WORK_DIR}"
  fi
}

trap cleanup EXIT

# ============================================================================
# Step 1: Detect existing OpenCode
# ============================================================================

detect_opencode() {
  header "Step 1/4: Detecting existing OpenCode installation"

  local found=false

  if command -v opencode >/dev/null 2>&1; then
    local oc_version
    oc_version="$(opencode --version 2>/dev/null || echo 'unknown')"
    info "OpenCode CLI found: v${oc_version} ($(command -v opencode))"
    found=true
  else
    info "OpenCode CLI: not installed"
  fi

  if [[ -d "${OPENCODE_CONFIG_DIR}" ]]; then
    local skill_count cmd_count
    skill_count="$(find "${OPENCODE_CONFIG_DIR}/skills" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l || echo 0)"
    cmd_count="$(find "${OPENCODE_CONFIG_DIR}/commands" -name '*.md' 2>/dev/null | wc -l || echo 0)"
    info "Config directory: ${OPENCODE_CONFIG_DIR} (${skill_count} skills, ${cmd_count} commands)"
    found=true
  else
    info "Config directory: not found"
  fi

  if [[ -d "${OPENCODE_DATA_DIR}" ]]; then
    info "Data directory: ${OPENCODE_DATA_DIR}"
    found=true
  fi

  if [[ "${found}" == "true" ]]; then
    log "Existing OpenCode installation detected"
    return 0
  else
    log "No existing installation found — fresh install"
    return 1
  fi
}

# ============================================================================
# Step 2: Reset / prepare profile directory
# ============================================================================

reset_profile() {
  header "Step 2/4: Resetting OpenCode profile"

  if [[ -d "${OPENCODE_CONFIG_DIR}" ]]; then
    local backup_path="${OPENCODE_CONFIG_DIR}.backup-$(date +%Y%m%d-%H%M%S)"
    info "Backing up existing config to: ${backup_path}"
    cp -r "${OPENCODE_CONFIG_DIR}" "${backup_path}" 2>/dev/null || true
    rm -rf "${OPENCODE_CONFIG_DIR}"
    log "Profile reset (backup saved)"
  else
    info "No existing profile to reset"
  fi

  if [[ -d "${OPENCODE_STATE_DIR}" ]]; then
    rm -rf "${OPENCODE_STATE_DIR}"
    log "State directory cleaned"
  fi

  # Uninstall old opencode-ai if doing full reset
  if command -v npm >/dev/null 2>&1; then
    if npm list -g opencode-ai >/dev/null 2>&1; then
      info "Removing existing opencode-ai npm package..."
      npm uninstall -g opencode-ai 2>/dev/null || true
      log "Old opencode-ai removed"
    fi
  fi

  log "Clean slate ready"
}

# ============================================================================
# Step 3: Install OpenCode CLI
# ============================================================================

install_opencode() {
  header "Step 3/4: Installing OpenCode CLI"

  if command -v opencode >/dev/null 2>&1; then
    local current_ver
    current_ver="$(opencode --version 2>/dev/null || echo 'unknown')"
    log "OpenCode CLI already installed: v${current_ver}"
    return
  fi

  if [[ "${SKIP_OPENCODE_INSTALL}" == "true" ]]; then
    warn "Skipping OpenCode CLI install (--skip-opencode). Profile will be installed only."
    return
  fi

  # Check for npm
  if ! command -v npm >/dev/null 2>&1; then
    # Try to install Node.js
    if ! command -v node >/dev/null 2>&1; then
      if is_debian_family; then
        info "Node.js not found. Installing..."
        run_as_root apt-get update -qq
        run_as_root apt-get install -y -qq nodejs npm >/dev/null 2>&1 || true
      fi
    fi

    if ! command -v npm >/dev/null 2>&1; then
      die "npm is required to install OpenCode CLI. Install Node.js 18+ first:
  Ubuntu/Debian: sudo apt install nodejs npm
  macOS:         brew install node
  Other:         https://nodejs.org"
    fi
  fi

  info "Installing OpenCode CLI via npm..."
  if npm install -g opencode-ai 2>&1; then
    local installed_ver
    installed_ver="$(opencode --version 2>/dev/null || echo 'unknown')"
    log "OpenCode CLI installed: v${installed_ver}"
  else
    # Try with sudo
    if have_sudo; then
      info "Retrying with sudo..."
      sudo npm install -g opencode-ai 2>&1
      log "OpenCode CLI installed with sudo"
    else
      die "Failed to install OpenCode CLI. Try: sudo npm install -g opencode-ai"
    fi
  fi
}

# ============================================================================
# Step 4: Install profile
# ============================================================================

prepare_source() {
  if [[ -n "${SOURCE_DIR}" && -d "${SOURCE_DIR}/opencode-profile" ]]; then
    log "Using local source: ${SOURCE_DIR}"
    return
  fi

  # Check if script is running from the repo directory
  # NOTE: BASH_SOURCE is unbound when piped from curl, so use default empty
  if [[ -z "${SOURCE_DIR}" ]]; then
    local script_dir=""
    if [[ -n "${BASH_SOURCE[0]:-}" ]]; then
      script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"
    fi
    if [[ -n "${script_dir}" && -d "${script_dir}/opencode-profile" ]]; then
      SOURCE_DIR="${script_dir}"
      log "Using script directory: ${SOURCE_DIR}"
      return
    fi
  fi

  # Clone the repository
  if ! command -v git >/dev/null 2>&1; then
    if is_debian_family; then
      run_as_root apt-get update -qq
      run_as_root apt-get install -y -qq git >/dev/null 2>&1
    else
      die "git is required. Install git and retry."
    fi
  fi

  WORK_DIR="$(mktemp -d)"
  SOURCE_DIR="${WORK_DIR}/my_opencode"
  info "Cloning repository..."
  git clone --depth 1 --branch "${INSTALL_REF}" "${REPO_URL}" "${SOURCE_DIR}" 2>&1
  log "Repository cloned"
}

install_profile() {
  header "Step 4/4: Installing super profile"

  prepare_source

  local profile_src="${SOURCE_DIR}/opencode-profile"
  [[ -d "${profile_src}" ]] || die "Profile directory not found at: ${profile_src}"

  # Create config directory
  mkdir -p "${OPENCODE_CONFIG_DIR}"

  # Copy config files
  info "Copying configuration files..."
  cp "${profile_src}/opencode.json" "${OPENCODE_CONFIG_DIR}/opencode.json"
  cp "${profile_src}/oh-my-opencode.json" "${OPENCODE_CONFIG_DIR}/oh-my-opencode.json"
  log "Config files installed"

  # Copy commands
  info "Installing commands..."
  mkdir -p "${OPENCODE_CONFIG_DIR}/commands"
  cp "${profile_src}"/commands/*.md "${OPENCODE_CONFIG_DIR}/commands/"
  local cmd_count
  cmd_count="$(ls -1 "${OPENCODE_CONFIG_DIR}/commands/"*.md | wc -l)"
  log "${cmd_count} commands installed"

  # Copy skills
  info "Installing skills..."
  mkdir -p "${OPENCODE_CONFIG_DIR}/skills"
  cp -r "${profile_src}"/skills/* "${OPENCODE_CONFIG_DIR}/skills/"
  local skill_count
  skill_count="$(find "${OPENCODE_CONFIG_DIR}/skills" -maxdepth 1 -mindepth 1 -type d | wc -l)"
  log "${skill_count} skills installed"

  # Copy plugins
  info "Installing plugins..."
  mkdir -p "${OPENCODE_CONFIG_DIR}/plugins"
  cp "${profile_src}"/plugins/* "${OPENCODE_CONFIG_DIR}/plugins/"
  log "Plugins installed"

  # Copy bin scripts
  info "Installing helper scripts..."
  mkdir -p "${OPENCODE_CONFIG_DIR}/bin"
  cp "${profile_src}"/bin/* "${OPENCODE_CONFIG_DIR}/bin/"
  chmod +x "${OPENCODE_CONFIG_DIR}/bin/"*
  log "Helper scripts installed"

  # Install npm dependencies (oh-my-opencode, plugin SDK)
  info "Installing profile dependencies..."
  cp "${profile_src}/package.json" "${OPENCODE_CONFIG_DIR}/package.json"
  cp "${profile_src}/package-lock.json" "${OPENCODE_CONFIG_DIR}/package-lock.json"
  if command -v npm >/dev/null 2>&1; then
    npm --prefix "${OPENCODE_CONFIG_DIR}" ci --omit=dev 2>&1
    log "Profile dependencies installed"
  else
    warn "npm not found — skipping profile dependency install."
    warn "Run manually: npm --prefix ~/.config/opencode ci --omit=dev"
  fi

  # Create data directories
  mkdir -p "${OPENCODE_DATA_DIR}"
  mkdir -p "${HOME}/.cache/opencode" 2>/dev/null || true

  log "Super profile installation complete"
}

# ============================================================================
# Summary
# ============================================================================

print_summary() {
  local oc_version
  oc_version="$(opencode --version 2>/dev/null || echo 'not installed')"

  printf "\n"
  printf "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
  printf "${BOLD}${GREEN}  ✅ OpenCode Super Assistant — Installation Complete!${NC}\n"
  printf "${BOLD}${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
  printf "\n"
  printf "  ${BOLD}OpenCode:${NC} v%s\n" "${oc_version}"
  printf "  ${BOLD}Profile:${NC}  %s\n" "${OPENCODE_CONFIG_DIR}"
  printf "  ${BOLD}Log:${NC}      %s\n" "${LOG_FILE}"
  printf "\n"
  printf "  ${BOLD}Installed:${NC}\n"
  printf "    • 46 skills (prompt-engineer, data-modeling, kubernetes-deploy, ...)\n"
  printf "    • 36 commands (/diagram, /explain, /diff-review, /ship, ...)\n"
  printf "    • 26 agents (6 primary + 20 subagent)\n"
  printf "    • 3 MCP servers (context7, gh_grep, websearch)\n"
  printf "    • 2 plugins (oh-my-opencode, oh-my-local)\n"
  printf "\n"
  printf "  ${BOLD}Quick start:${NC}\n"
  printf "    ${CYAN}opencode${NC}\n"
  printf "\n"
  printf "  ${BOLD}Verify installation:${NC}\n"
  printf "    Inside OpenCode, type: ${CYAN}/doctor${NC}\n"
  printf "    List agents:  ${CYAN}/agents${NC}\n"
  printf "    List skills:  ${CYAN}/skills${NC}\n"
  printf "    List commands: ${CYAN}/help${NC}\n"
  printf "\n"
  printf "  ${BOLD}Optional API keys (set before running):${NC}\n"
  printf "    export OPENAI_API_KEY=\"sk-...\"\n"
  printf "    export ANTHROPIC_API_KEY=\"sk-ant-...\"\n"
  printf "    export GOOGLE_API_KEY=\"...\"\n"
  printf "    export CONTEXT7_API_KEY=\"...\"\n"
  printf "    export EXA_API_KEY=\"...\"\n"
  printf "\n"
}

# ============================================================================
# Main
# ============================================================================

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source)
      SOURCE_DIR="$2"
      shift 2
      ;;
    --repo)
      REPO_URL="$2"
      shift 2
      ;;
    --ref)
      INSTALL_REF="$2"
      shift 2
      ;;
    --reset)
      FORCE_RESET="true"
      shift
      ;;
    --no-reset)
      SKIP_RESET="true"
      shift
      ;;
    --skip-opencode)
      SKIP_OPENCODE_INSTALL="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1. Use --help for usage."
      ;;
  esac
done

# --- Banner ---
printf "\n"
printf "${BOLD}${CYAN}"
printf "  ╔═══════════════════════════════════════════════════╗\n"
printf "  ║        OpenCode Super Assistant Installer         ║\n"
printf "  ║     46 Skills • 36 Commands • 26 Agents           ║\n"
printf "  ╚═══════════════════════════════════════════════════╝\n"
printf "${NC}\n"

setup_logging

# Step 1: Detect
existing_found=false
if detect_opencode; then
  existing_found=true
fi

# Step 2: Reset if needed
if [[ "${existing_found}" == "true" ]]; then
  if [[ "${FORCE_RESET}" == "true" ]]; then
    reset_profile
  elif [[ "${SKIP_RESET}" == "true" ]]; then
    info "Skipping reset (--no-reset). Upgrading profile in place."
  else
    if [[ ! -t 0 ]]; then
      # Non-interactive (piped) — auto reset
      info "Non-interactive mode. Resetting profile for clean install."
      reset_profile
    else
      printf "\n"
      printf "${YELLOW}Existing OpenCode profile detected.${NC}\n"
      printf "  1) Reset and reinstall (recommended)\n"
      printf "  2) Upgrade in place (keep data)\n"
      printf "  3) Cancel\n"
      printf "\n"
      read -rp "Choose [1/2/3] (default: 1): " choice
      case "${choice}" in
        2) info "Upgrading in place..." ;;
        3) log "Cancelled."; exit 0 ;;
        *) reset_profile ;;
      esac
    fi
  fi
else
  info "Fresh install — no reset needed."
fi

# Step 3: Install OpenCode CLI
install_opencode

# Step 4: Install profile
install_profile

# Done
print_summary
