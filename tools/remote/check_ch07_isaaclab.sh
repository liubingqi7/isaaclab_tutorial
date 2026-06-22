#!/usr/bin/env bash
set -euo pipefail

HOST="${1:-liubingqi@192.168.2.16}"
ROOT="${2:-/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0}"
ENV_NAME="${3:-env_isaaclab_2.3_lbq}"

ssh "${HOST}" "ROOT='${ROOT}' ENV_NAME='${ENV_NAME}' bash -s" <<'REMOTE'
set -euo pipefail

source ~/miniconda3/etc/profile.d/conda.sh
conda activate "${ENV_NAME}"
cd "${ROOT}"

echo "== source =="
git describe --tags --always --dirty
git rev-parse HEAD
git status --short

echo "== files =="
for path in \
  scripts/demos/multi_asset.py \
  scripts/tutorials/02_scene/create_scene.py \
  scripts/reinforcement_learning/rsl_rl/train.py \
  source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion/velocity/config/g1/__init__.py
do
  test -f "${path}" && echo "FOUND ${path}" || echo "MISSING ${path}"
done

echo "== packages =="
python - <<'PY'
import importlib.metadata as md

for package in ["isaacsim", "isaacsim-app", "isaacsim-core", "isaacsim-rl", "torch"]:
    try:
        print(package, md.version(package))
    except Exception as exc:
        print(package, type(exc).__name__)
PY

echo "== entrypoints =="
./isaaclab.sh --help | sed -n '1,40p'
./isaaclab.sh -p scripts/demos/multi_asset.py --help | sed -n '1,80p'

echo "== plain python runtime modules =="
python - <<'PY'
import importlib.util

for name in ["carb", "omni", "pxr"]:
    print(name, "FOUND" if importlib.util.find_spec(name) else "MISSING")
PY

echo "== system resource hint =="
df -h /home /tmp 2>/dev/null || true
cat /proc/sys/fs/inotify/max_user_watches
cat /proc/sys/fs/inotify/max_user_instances
cat /proc/sys/fs/inotify/max_queued_events
REMOTE
