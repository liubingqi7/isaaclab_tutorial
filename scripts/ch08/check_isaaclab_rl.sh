#!/usr/bin/env bash
set -euo pipefail

ISAACLAB_DIR="${1:-${ISAACLAB_PATH:-}}"

if [ -z "${ISAACLAB_DIR}" ]; then
  printf 'Usage: %s /path/to/IsaacLab-v2.3.0\n' "$0" >&2
  exit 2
fi

cd "${ISAACLAB_DIR}"

for path in \
  isaaclab.sh \
  scripts/reinforcement_learning/rsl_rl/train.py \
  scripts/reinforcement_learning/rsl_rl/play.py \
  source/isaaclab/isaaclab/envs/direct_rl_env.py \
  source/isaaclab/isaaclab/envs/manager_based_env.py \
  source/isaaclab/isaaclab/envs/manager_based_rl_env.py \
  source/isaaclab_tasks/isaaclab_tasks/direct/cartpole \
  source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion/velocity
do
  if [ ! -e "${path}" ]; then
    printf 'missing: %s\n' "${path}" >&2
    exit 1
  fi
  printf 'ok: %s\n' "${path}"
done

printf '\n== RSL-RL train CLI ==\n'
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/train.py --help | sed -n '1,80p'
