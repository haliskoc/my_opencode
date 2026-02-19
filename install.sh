#!/usr/bin/env bash
set -euo pipefail

REPO_URL_DEFAULT="https://github.com/haliskoc/my_opencode.git"
INSTALL_REF="main"
INSTALL_BIN_DIR="${HOME}/.local/bin"
LAUNCHER_PATH="${INSTALL_BIN_DIR}/opencode-super"
WORK_ROOT="${HOME}/.local/share/opencode-super"

SOURCE_DIR=""
REPO_URL="${REPO_URL_DEFAULT}"
INSTALL_DOCKER_IF_MISSING="true"
INSTALL_HOST_OPENCODE_IF_MISSING="true"
APP_VERSION=""
IMAGE_TAG=""
LOG_FILE=""

log() {
  printf '%s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  if [[ -n "${LOG_FILE}" ]]; then
    printf 'Log file: %s\n' "${LOG_FILE}" >&2
  fi
  exit 1
}

usage() {
  cat <<EOF
Usage:
  ./install.sh [--source /path/to/repo] [--repo ${REPO_URL_DEFAULT}]

Options:
  --source                Local directory containing Dockerfile and profile
  --repo                  Repository URL to clone if --source is not provided
  --no-install-docker     Do not auto-install Docker when missing
  --skip-host-opencode    Do not install host opencode CLI
  --ref <git-ref>         Git branch/tag/commit-ish to install from (default: main)
  --version <x.y.z>       Override version tag for image/launcher

Examples:
  ./install.sh
  ./install.sh --source /home/user/my_opencode
  ./install.sh --repo ${REPO_URL_DEFAULT}
  ./install.sh --ref v1.0.0 --version 1.0.0
EOF
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

setup_logging() {
  mkdir -p "${WORK_ROOT}/logs"
  LOG_FILE="${WORK_ROOT}/logs/install-$(date +%Y%m%d-%H%M%S).log"
  exec > >(tee -a "${LOG_FILE}") 2>&1
  trap 'die "Installation failed."' ERR
}

install_docker_debian_or_ubuntu() {
  local distro codename
  distro=""
  codename=""

  if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    if [[ "${ID:-}" == "ubuntu" ]]; then
      distro="ubuntu"
      codename="${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}"
    elif [[ "${ID:-}" == "debian" ]]; then
      distro="debian"
      codename="${VERSION_CODENAME:-}"
    fi
  fi

  [[ -n "${distro}" ]] || die "Unsupported distro for auto Docker install."
  [[ -n "${codename}" ]] || die "Could not detect distro codename for Docker repo setup."

  log "Docker not found. Installing Docker (${distro}/${codename})..."
  run_as_root apt-get update
  run_as_root apt-get install -y ca-certificates curl gnupg
  run_as_root install -m 0755 -d /etc/apt/keyrings
  run_as_root bash -c "curl -fsSL https://download.docker.com/linux/${distro}/gpg -o /etc/apt/keyrings/docker.asc"
  run_as_root chmod a+r /etc/apt/keyrings/docker.asc
  run_as_root bash -c "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/${distro} ${codename} stable\" > /etc/apt/sources.list.d/docker.list"
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

resolve_version() {
  if [[ -n "${APP_VERSION}" ]]; then
    return
  fi
  if [[ -f "${SOURCE_DIR}/VERSION" ]]; then
    APP_VERSION="$(tr -d '[:space:]' < "${SOURCE_DIR}/VERSION")"
  fi
  if [[ -z "${APP_VERSION}" ]]; then
    APP_VERSION="1.0.0"
  fi
}

build_install_url() {
  printf 'https://raw.githubusercontent.com/haliskoc/my_opencode/%s/install.sh' "${INSTALL_REF}"
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
    --ref)
      INSTALL_REF="$2"
      shift 2
      ;;
    --version)
      APP_VERSION="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

setup_logging

if ! command -v docker >/dev/null 2>&1; then
  if [[ "${INSTALL_DOCKER_IF_MISSING}" == "true" ]]; then
    if is_debian_family; then
      install_docker_debian_or_ubuntu
    else
      die "Docker not found and auto-install supports Debian/Ubuntu only. Install Docker manually."
    fi
  else
    die "Docker not found. Re-run without --no-install-docker or install Docker manually."
  fi
fi

docker_cmd info >/dev/null 2>&1 || die "Docker daemon is not running or inaccessible. Start Docker and retry."

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
  mkdir -p "${WORK_ROOT}"
  SOURCE_DIR="${WORK_ROOT}/repo"
  rm -rf "${SOURCE_DIR}"
  git clone --depth 1 --branch "${INSTALL_REF}" "${REPO_URL}" "${SOURCE_DIR}"
fi

[[ -f "${SOURCE_DIR}/Dockerfile" ]] || die "Dockerfile not found at: ${SOURCE_DIR}"

resolve_version
IMAGE_TAG="opencode-super:${APP_VERSION}"
INSTALL_URL="$(build_install_url)"

log "Building image: ${IMAGE_TAG}"
docker_cmd build -t "${IMAGE_TAG}" -t opencode-super:latest "${SOURCE_DIR}"

mkdir -p "${INSTALL_BIN_DIR}"
cat >"${LAUNCHER_PATH}" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

APP_VERSION="__APP_VERSION__"
IMAGE_TAG="__IMAGE_TAG__"
INSTALL_URL="__INSTALL_URL__"

if docker info >/dev/null 2>&1; then
  DOCKER_BIN="docker"
elif command -v sudo >/dev/null 2>&1; then
  DOCKER_BIN="sudo docker"
else
  echo "Docker is not accessible for current user." >&2
  exit 1
fi

if [[ "${1:-}" == "--version" || "${1:-}" == "version" ]]; then
  echo "opencode-super launcher version: ${APP_VERSION}"
  ${DOCKER_BIN} image inspect "${IMAGE_TAG}" >/dev/null 2>&1 && echo "image present: ${IMAGE_TAG}" || echo "image missing: ${IMAGE_TAG}"
  exit 0
fi

if [[ "${1:-}" == "--self-update" || "${1:-}" == "self-update" ]]; then
  curl -fsSL "${INSTALL_URL}" | bash
  exit 0
fi

RUNTIME_UID="${OPENCODE_SUPER_UID:-$(id -u)}"
RUNTIME_GID="${OPENCODE_SUPER_GID:-$(id -g)}"

EXTRA_SECURITY_FLAGS=()
if [[ "${OPENCODE_SUPER_UNSAFE:-0}" != "1" ]]; then
  EXTRA_SECURITY_FLAGS=(
    --read-only
    --tmpfs /tmp:rw,noexec,nosuid,size=256m,mode=1777
    --tmpfs /home/opencode/.cache:rw,noexec,nosuid,size=256m,uid=${RUNTIME_UID},gid=${RUNTIME_GID},mode=0755
    --tmpfs /home/opencode/.local/state:rw,noexec,nosuid,size=128m,uid=${RUNTIME_UID},gid=${RUNTIME_GID},mode=0755
    --security-opt no-new-privileges:true
    --cap-drop ALL
    --pids-limit 512
  )
fi

${DOCKER_BIN} run -it --rm "${EXTRA_SECURITY_FLAGS[@]}" \
  --user "${RUNTIME_UID}:${RUNTIME_GID}" \
  -v "${PWD}:/workspace" \
  -v "${HOME}/.local/share/opencode:/home/opencode/.local/share/opencode" \
  -e OPENAI_API_KEY="${OPENAI_API_KEY:-}" \
  -e CONTEXT7_API_KEY="${CONTEXT7_API_KEY:-}" \
  -e EXA_API_KEY="${EXA_API_KEY:-}" \
  "${IMAGE_TAG}" "$@"
EOF
sed -i "s|__APP_VERSION__|${APP_VERSION}|g; s|__IMAGE_TAG__|${IMAGE_TAG}|g; s|__INSTALL_URL__|${INSTALL_URL}|g" "${LAUNCHER_PATH}"
chmod +x "${LAUNCHER_PATH}"

log
log "Installation complete."
log "Run: opencode-super"
log "Version: ${APP_VERSION}"
log "Log file: ${LOG_FILE}"

if [[ ":$PATH:" != *":${INSTALL_BIN_DIR}:"* ]]; then
  log "If command is not found, run:"
  log "  export PATH=\"${INSTALL_BIN_DIR}:\$PATH\""
fi
