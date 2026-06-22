# Repository Instructions

This directory is the management workspace for the Isaac Lab portion of the book
`具身智能仿真实战：构建、训练与部署.pdf`.

## Scope

- Focus only on chapters 7-10, the Isaac Lab related part of the book.
- Do not organize or validate ManiSkill chapters unless explicitly requested.
- The local workspace should contain management documents, source maps, notes,
  manifests, and small helper scripts. Primary source repositories and compute
  run on the workstation `192.168.2.16`.

## Remote Workstation

- Host: `liubingqi@192.168.2.16`
- Isaac Lab conda env: `env_isaaclab_2.3_lbq`
- Primary Isaac Lab checkout: `/home/liubingqi/lbq/IsaacLab`
- Existing related checkouts:
  - `/home/liubingqi/lbq/humanoid-lab`
  - `/home/liubingqi/lbq/unitree_rl_lab`
  - `/home/liubingqi/lbq/unitree_mujoco`
  - `/home/liubingqi/lbq/humanoid-lab/Retargeting/GMR`

Treat remote repositories as shared working state. Inspect read-only first. Do
not reset, clean, delete, stop jobs, or overwrite remote files unless explicitly
asked.

## Source Of Truth

- Internet source identification should use upstream public repositories first:
  - `https://github.com/isaac-sim/IsaacLab`
  - `https://github.com/leggedrobotics/rsl_rl`
  - `https://github.com/unitreerobotics/unitree_rl_lab`
  - `https://github.com/unitreerobotics/unitree_mujoco`
  - `https://github.com/unitreerobotics/unitree_sdk2`
  - `https://github.com/HybridRobotics/whole_body_tracking`
  - `https://github.com/YanjieZe/GMR`
- Prefer exact tags or commits matching the book. The book states Isaac Lab
  `v2.3.0` and Isaac Sim `5.1.0`.
- When local remote checkouts differ from upstream, record both the upstream
  target and remote checkout state before changing anything.

## Validation Rules

- Use `192.168.2.16` for source checkout validation and runtime checks.
- Start with lightweight checks: repository path exists, git remote/commit,
  task files exist, package imports, command help output.
- GUI, long training, MuJoCo windows, or GPU-heavy jobs require an explicit
  run plan and should report process, log, and output paths.
- Distinguish measured facts from assumptions in notes and final reports.

## Current Known State As Of 2026-06-22

- Local directory initially contained only the PDF and was not a git repository.
- `/home/liubingqi/lbq/IsaacLab` is on branch `main` at
  `v2.2.1-199-g0aa7837e3a`, not exactly the book's `v2.3.0` tag.
- `/home/liubingqi/lbq/unitree_rl_lab` is sparse-checked to `deploy`; the
  book's `source/unitree_rl_lab/unitree_rl_lab/tasks/mimic` path is present in
  upstream but not currently materialized in that local checkout.
- Direct Python import in `env_isaaclab_2.3_lbq` found `isaacsim==5.1.0.0` and
  `isaaclab`, but `isaaclab_tasks` import failed with `ModuleNotFoundError:
  No module named 'pxr'`. Treat Isaac Sim/Kit Python exposure as a validation
  blocker until resolved.
- `/home/liubingqi/lbq/humanoid-lab` and `/home/liubingqi/lbq/unitree_mujoco`
  have existing uncommitted changes.
