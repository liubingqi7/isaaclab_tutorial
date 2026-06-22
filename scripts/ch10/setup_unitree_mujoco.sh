#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-${HOME}/isaaclab_sources/unitree_mujoco}"
REPO_URL="https://github.com/unitreerobotics/unitree_mujoco.git"

if [ -d "${TARGET_DIR}/.git" ]; then
  git -C "${TARGET_DIR}" pull --ff-only
else
  mkdir -p "$(dirname "${TARGET_DIR}")"
  git clone "${REPO_URL}" "${TARGET_DIR}"
fi

printf 'unitree_mujoco source is ready: %s\n' "${TARGET_DIR}"
git -C "${TARGET_DIR}" rev-parse --short HEAD
