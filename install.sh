#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="opencode-super:latest"
INSTALL_BIN_DIR="${HOME}/.local/bin"
LAUNCHER_PATH="${INSTALL_BIN_DIR}/opencode-super"
WORK_ROOT="${HOME}/.local/share/opencode-super"
SOURCE_DIR=""
REPO_URL="https://github.com/haliskoc/my_opencode.git"
INSTALL_DOCKER_IF_MISSING="true"
INSTALL_HOST_OPENCODE_IF_MISSING="true"

log() {
  printf '%s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

is_debian_family() {
  [[ -f /etc/debian_version ]]
}

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

docker_cmd() {
  if docker info >/dev/null 2>&1; then
    docker "$@"
    return
  fi
  if have_sudo; then
    sudo docker "$@"
    return
  fi
  die "Docker is installed but not accessible. Add your user to docker group or use sudo."
}

install_docker_debian() {
  log "Docker not found. Installing Docker (Debian/Ubuntu)..."
  run_as_root apt-get update
  run_as_root apt-get install -y ca-certificates curl gnupg lsb-release
  run_as_root install -m 0755 -d /etc/apt/keyrings
  run_as_root bash -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc"
  run_as_root chmod a+r /etc/apt/keyrings/docker.asc
  run_as_root bash -c "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \$UBUNTU_CODENAME) stable\" > /etc/apt/sources.list.d/docker.list"
  run_as_root apt-get update
  run_as_root apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin git
}

maybe_install_host_opencode() {
  if command -v opencode >/dev/null 2>&1; then
    log "Host OpenCode already installed: $(opencode --version 2>/dev/null || echo unknown)"
    return
  fi
  if [[ "${INSTALL_HOST_OPENCODE_IF_MISSING}" != "true" ]]; then
    warn "Host OpenCode missing. Skipping by option. Docker image still includes OpenCode."
    return
  fi
  if command -v npm >/dev/null 2>&1; then
    log "Installing host OpenCode CLI with npm..."
    if npm install -g opencode-ai >/dev/null 2>&1; then
      log "Host OpenCode installed."
      return
    fi
    warn "Host OpenCode installation failed. Continuing with Docker-only setup."
    return
  fi
  warn "npm not found. Skipping host OpenCode install. Docker image remains ready to use."
}

usage() {
  cat <<'EOF'
Usage:
  ./install.sh [--source /path/to/repo] [--repo https://github.com/haliskoc/my_opencode.git]

Options:
  --source                Local directory containing Dockerfile and profile
  --repo                  Repository URL to clone if --source is not provided
  --no-install-docker     Do not auto-install Docker when missing
  --skip-host-opencode    Do not install host opencode CLI

Examples:
  ./install.sh
  ./install.sh --source /home/user/my_opencode
  ./install.sh --repo https://github.com/haliskoc/my_opencode.git
EOF
}

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
    --no-install-docker)
      INSTALL_DOCKER_IF_MISSING="false"
      shift
      ;;
    --skip-host-opencode)
      INSTALL_HOST_OPENCODE_IF_MISSING="false"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if ! command -v docker >/dev/null 2>&1; then
  if [[ "${INSTALL_DOCKER_IF_MISSING}" == "true" ]]; then
    if is_debian_family; then
      install_docker_debian
    else
      die "Docker not found and automatic install supports Debian/Ubuntu only. Install Docker manually."
    fi
  else
    die "Docker not found. Re-run without --no-install-docker or install Docker manually."
  fi
fi

if ! docker_cmd info >/dev/null 2>&1; then
  die "Docker daemon is not running or inaccessible. Start Docker and retry."
fi

if ! command -v git >/dev/null 2>&1; then
  if is_debian_family; then
    run_as_root apt-get update
    run_as_root apt-get install -y git
  else
    die "git not found. Install git and retry."
  fi
fi

maybe_install_host_opencode

if [[ -z "${SOURCE_DIR}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -f "${SCRIPT_DIR}/Dockerfile" ]]; then
    SOURCE_DIR="${SCRIPT_DIR}"
  fi
fi

if [[ -z "${SOURCE_DIR}" ]]; then
  if [[ -z "${REPO_URL}" ]]; then
    die "Source directory not found. Provide --source or --repo."
  fi

  mkdir -p "${WORK_ROOT}"
  SOURCE_DIR="${WORK_ROOT}/repo"
  rm -rf "${SOURCE_DIR}"
  git clone --depth 1 "${REPO_URL}" "${SOURCE_DIR}"
fi

if [[ ! -f "${SOURCE_DIR}/Dockerfile" ]]; then
  die "Dockerfile not found at: ${SOURCE_DIR}"
fi

log "Building image: ${IMAGE_TAG}"
docker_cmd build -t "${IMAGE_TAG}" "${SOURCE_DIR}"

mkdir -p "${INSTALL_BIN_DIR}"
cat >"${LAUNCHER_PATH}" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if docker info >/dev/null 2>&1; then
  DOCKER_BIN="docker"
elif command -v sudo >/dev/null 2>&1; then
  DOCKER_BIN="sudo docker"
else
  echo "Docker is not accessible for current user." >&2
  exit 1
fi

${DOCKER_BIN} run -it --rm \
  -v "${PWD}:/workspace" \
  -v "${HOME}/.local/share/opencode:/root/.local/share/opencode" \
  -e OPENAI_API_KEY="${OPENAI_API_KEY:-}" \
  -e CONTEXT7_API_KEY="${CONTEXT7_API_KEY:-}" \
  -e EXA_API_KEY="${EXA_API_KEY:-}" \
  opencode-super:latest "$@"
EOF
chmod +x "${LAUNCHER_PATH}"

log
log "Installation complete."
log "Run: opencode-super"
log
if [[ ":$PATH:" != *":${INSTALL_BIN_DIR}:"* ]]; then
  log "If command is not found, run:"
  log "  export PATH=\"${INSTALL_BIN_DIR}:\$PATH\""
fi
