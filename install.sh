#!/usr/bin/env bash
set -euo pipefail

IMAGE_TAG="opencode-super:latest"
INSTALL_BIN_DIR="${HOME}/.local/bin"
LAUNCHER_PATH="${INSTALL_BIN_DIR}/opencode-super"
WORK_ROOT="${HOME}/.local/share/opencode-super"
SOURCE_DIR=""
REPO_URL=""

usage() {
  cat <<'EOF'
Usage:
  ./install.sh [--source /path/to/opencode-docker] [--repo https://github.com/you/repo.git]

Options:
  --source   Local directory containing Dockerfile and opencode profile
  --repo     Git repository to clone if --source is not provided

Examples:
  ./install.sh
  ./install.sh --source /home/user/opencode-docker
  ./install.sh --repo https://github.com/acme/opencode-super.git
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
  echo "Docker bulunamadi. Once Docker kurun." >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker daemon calismiyor veya yetki yok. Docker'i baslatin." >&2
  exit 1
fi

if [[ -z "${SOURCE_DIR}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -f "${SCRIPT_DIR}/Dockerfile" ]]; then
    SOURCE_DIR="${SCRIPT_DIR}"
  fi
fi

if [[ -z "${SOURCE_DIR}" ]]; then
  if [[ -z "${REPO_URL}" ]]; then
    echo "Kaynak klasor bulunamadi. --source veya --repo verin." >&2
    exit 1
  fi

  mkdir -p "${WORK_ROOT}"
  SOURCE_DIR="${WORK_ROOT}/repo"
  rm -rf "${SOURCE_DIR}"
  git clone --depth 1 "${REPO_URL}" "${SOURCE_DIR}"
fi

if [[ ! -f "${SOURCE_DIR}/Dockerfile" ]]; then
  echo "Dockerfile bulunamadi: ${SOURCE_DIR}" >&2
  exit 1
fi

echo "Image build ediliyor: ${IMAGE_TAG}"
docker build -t "${IMAGE_TAG}" "${SOURCE_DIR}"

mkdir -p "${INSTALL_BIN_DIR}"
cat >"${LAUNCHER_PATH}" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

docker run -it --rm \
  -v "${PWD}:/workspace" \
  -v "${HOME}/.local/share/opencode:/root/.local/share/opencode" \
  -e OPENAI_API_KEY="${OPENAI_API_KEY:-}" \
  -e CONTEXT7_API_KEY="${CONTEXT7_API_KEY:-}" \
  -e EXA_API_KEY="${EXA_API_KEY:-}" \
  opencode-super:latest "$@"
EOF
chmod +x "${LAUNCHER_PATH}"

echo
echo "Kurulum tamamlandi."
echo "Calistirmak icin: opencode-super"
echo
if [[ ":$PATH:" != *":${INSTALL_BIN_DIR}:"* ]]; then
  echo "Not: ${INSTALL_BIN_DIR} PATH'te degilse su komutu ekleyin:"
  echo "  export PATH=\"${INSTALL_BIN_DIR}:\$PATH\""
fi
