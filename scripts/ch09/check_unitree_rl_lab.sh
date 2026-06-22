#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-${UNITREE_RL_LAB_PATH:-}}"

if [ -z "${ROOT}" ]; then
  printf 'Usage: %s /path/to/unitree_rl_lab\n' "$0" >&2
  exit 2
fi

cd "${ROOT}"

check_path() {
  local path="$1"
  if [ -e "${path}" ]; then
    printf 'ok: %s\n' "${path}"
    return
  fi
  if git ls-tree -r --name-only HEAD -- "${path}" | grep -Fxq "${path}"; then
    printf 'ok: %s (git object; not checked out)\n' "${path}"
    return
  fi
  printf 'missing: %s\n' "${path}" >&2
  exit 1
}

printf '== unitree_rl_lab source ==\n'
git rev-parse --short HEAD

printf '\n== Chapter 9 files ==\n'
for path in \
  scripts/rsl_rl/train.py \
  scripts/rsl_rl/play.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/locomotion/robots/g1/29dof/velocity_env_cfg.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/locomotion/mdp/commands/velocity_command.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/locomotion/mdp/rewards.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/mdp/commands.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/mdp/rewards.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/mdp/terminations.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/robots/g1_29dof/dance_102/tracking_env_cfg.py \
  source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/agents/rsl_rl_ppo_cfg.py
do
  check_path "${path}"
done
