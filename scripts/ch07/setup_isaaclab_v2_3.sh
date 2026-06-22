#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-${HOME}/isaaclab_sources/IsaacLab-v2.3.0}"
REPO_URL="https://github.com/isaac-sim/IsaacLab.git"
TAG="v2.3.0"

if [ -d "${TARGET_DIR}/.git" ]; then
  git -C "${TARGET_DIR}" fetch --tags --depth 1 origin "${TAG}"
else
  mkdir -p "$(dirname "${TARGET_DIR}")"
  git clone --depth 1 --branch "${TAG}" "${REPO_URL}" "${TARGET_DIR}"
fi

cd "${TARGET_DIR}"
git checkout "${TAG}"

printf 'Isaac Lab source is ready: %s\n' "${TARGET_DIR}"
printf 'Version: '
git describe --tags --always --dirty
printf '\nNext commands:\n'
printf '  conda activate env_isaaclab_2.3_lbq\n'
printf '  ./isaaclab.sh --install\n'
printf '  ./isaaclab.sh -p scripts/demos/multi_asset.py --help\n'
