#!/usr/bin/env bash
set -euo pipefail

MUJOCO_DIR="${1:-${UNITREE_MUJOCO_PATH:-}}"
RL_LAB_DIR="${2:-${UNITREE_RL_LAB_PATH:-}}"

if [ -z "${MUJOCO_DIR}" ] || [ -z "${RL_LAB_DIR}" ]; then
  printf 'Usage: %s /path/to/unitree_mujoco /path/to/unitree_rl_lab\n' "$0" >&2
  exit 2
fi

check_file() {
  local root="$1"
  local path="$2"
  if [ -e "${root}/${path}" ]; then
    printf 'ok: %s\n' "${path}"
    return
  fi
  if git -C "${root}" ls-tree -r --name-only HEAD -- "${path}" | grep -Fxq "${path}"; then
    printf 'ok: %s (git object; not checked out)\n' "${path}"
    return
  fi
  printf 'missing: %s\n' "${path}" >&2
  exit 1
}

printf '== unitree_mujoco ==\n'
git -C "${MUJOCO_DIR}" rev-parse --short HEAD
for path in \
  simulate/CMakeLists.txt \
  simulate/src/main.cc \
  simulate/src/unitree_sdk2_bridge.h \
  unitree_robots/g1/g1_29dof.xml \
  unitree_robots/g1/scene_29dof.xml
do
  check_file "${MUJOCO_DIR}" "${path}"
done

printf '\n== unitree_rl_lab deploy ==\n'
git -C "${RL_LAB_DIR}" rev-parse --short HEAD
for path in \
  deploy/include/FSM/CtrlFSM.h \
  deploy/include/FSM/State_RLBase.h \
  deploy/include/isaaclab/manager/action_manager.h \
  deploy/include/isaaclab/manager/observation_manager.h \
  deploy/robots/g1_29dof/CMakeLists.txt \
  deploy/robots/g1_29dof/config/config.yaml \
  deploy/robots/g1_29dof/main.cpp \
  deploy/robots/g1_29dof/src/State_Mimic.cpp
do
  check_file "${RL_LAB_DIR}" "${path}"
done

printf '\nExpected G1 deploy executable after build: g1_ctrl\n'
