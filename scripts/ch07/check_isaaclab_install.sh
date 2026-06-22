#!/usr/bin/env bash
set -euo pipefail

ISAACLAB_DIR="${1:-${ISAACLAB_PATH:-}}"

if [ -z "${ISAACLAB_DIR}" ]; then
  printf 'Usage: %s /path/to/IsaacLab-v2.3.0\n' "$0" >&2
  printf 'Or set ISAACLAB_PATH before running this script.\n' >&2
  exit 2
fi

if [ ! -f "${ISAACLAB_DIR}/isaaclab.sh" ]; then
  printf 'isaaclab.sh was not found under: %s\n' "${ISAACLAB_DIR}" >&2
  exit 2
fi

cd "${ISAACLAB_DIR}"

printf '== Isaac Lab source ==\n'
EXPECTED_TAG="v2.3.0"
ACTUAL_TAG="$(git describe --tags --exact-match HEAD 2>/dev/null || true)"

if [ "${ACTUAL_TAG}" != "${EXPECTED_TAG}" ]; then
  printf 'expected tag: %s\n' "${EXPECTED_TAG}" >&2
  printf 'actual tag: %s\n' "${ACTUAL_TAG:-not on an exact tag}" >&2
  exit 1
fi

printf 'tag: %s\n' "${ACTUAL_TAG}"
git rev-parse HEAD

printf '\n== Key files ==\n'
for path in \
  isaaclab.sh \
  scripts/demos/multi_asset.py \
  scripts/tutorials/02_scene/create_scene.py \
  scripts/reinforcement_learning/rsl_rl/train.py \
  source/isaaclab \
  source/isaaclab_assets \
  source/isaaclab_tasks \
  source/isaaclab_rl \
  source/isaaclab_mimic
do
  if [ ! -e "${path}" ]; then
    printf 'missing: %s\n' "${path}" >&2
    exit 1
  fi
  printf 'ok: %s\n' "${path}"
done

printf '\n== Python packages ==\n'
python - <<'PY'
from importlib import metadata

for name in ["isaacsim", "isaacsim-app", "isaacsim-core", "isaacsim-rl", "torch"]:
    try:
        print(f"{name}: {metadata.version(name)}")
    except metadata.PackageNotFoundError:
        print(f"{name}: not installed")
PY

printf '\n== Isaac Lab CLI ==\n'
./isaaclab.sh --help | sed -n '1,40p'

printf '\n== Chapter 7 demo CLI ==\n'
./isaaclab.sh -p scripts/demos/multi_asset.py --help | sed -n '1,80p'
