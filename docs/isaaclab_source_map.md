# Isaac Lab Source Map

This map covers only the Isaac Lab portion of the book:
`具身智能仿真实战：构建、训练与部署.pdf`, chapters 7-10.

## Book Scope

| Chapter | PDF pages | Main topic | Source focus |
| --- | ---: | --- | --- |
| 7 | 118-126 | Isaac Lab platform, install, project layout | IsaacLab repo, install scripts, demos |
| 8 | 127-152 | Task construction and RL training | IsaacLab tutorial scripts, task registration, RSL-RL train script |
| 9 | 153-184 | Unitree G1 locomotion and motion tracking | IsaacLab G1 locomotion, BeyondMimic, unitree_rl_lab mimic, GMR |
| 10 | 185-199 | Sim-to-real validation and deploy | unitree_mujoco, unitree_rl_lab/deploy, unitree_sdk2 |

## Upstream Sources Located

| Area | Upstream source | Book reference |
| --- | --- | --- |
| Isaac Lab framework | https://github.com/isaac-sim/IsaacLab | Ch. 7-8; book states Isaac Lab `v2.3.0` with Isaac Sim `5.1.0` |
| Isaac Lab RSL-RL integration | https://github.com/isaac-sim/IsaacLab/tree/v2.3.0/scripts/reinforcement_learning/rsl_rl | Ch. 8 training flow |
| RSL-RL library | https://github.com/leggedrobotics/rsl_rl | Ch. 8 mentions `leggedrobotics/rsl_rl` |
| G1 locomotion task | https://github.com/isaac-sim/IsaacLab/tree/v2.3.0/source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion/velocity/config/g1 | Ch. 9.2, task IDs including `Isaac-Velocity-Rough-G1-v0` |
| Unitree RL Lab | https://github.com/unitreerobotics/unitree_rl_lab | Ch. 9.3 and Ch. 10 deploy |
| Unitree mimic task | https://github.com/unitreerobotics/unitree_rl_lab/tree/main/source/unitree_rl_lab/unitree_rl_lab/tasks/mimic | Ch. 9.3 motion tracking |
| Unitree deploy | https://github.com/unitreerobotics/unitree_rl_lab/tree/main/deploy | Ch. 10.3 deploy architecture |
| BeyondMimic motion tracking | https://github.com/HybridRobotics/whole_body_tracking | Ch. 9.1-9.3 references BeyondMimic |
| GMR | https://github.com/YanjieZe/GMR | Ch. 9.3.2 motion retargeting |
| Unitree MuJoCo | https://github.com/unitreerobotics/unitree_mujoco | Ch. 10.2 software-in-the-loop simulation |
| Unitree SDK2 | https://github.com/unitreerobotics/unitree_sdk2 | Ch. 10.2-10.4 DDS/LowCmd/LowState dependency |

## Chapter To Code Mapping

### Chapter 7 - Isaac Lab Ecosystem

- Book installation target:
  - Isaac Sim `5.1.0`
  - Isaac Lab `v2.3.0`
  - Python `3.11`
- Main upstream repo:
  - `https://github.com/isaac-sim/IsaacLab`
- Book demo:
  - `scripts/demos/multi_asset.py`
- Remote status:
  - Clean textbook checkout: `/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0`.
  - Clean checkout is `v2.3.0`, commit `3c6e67bb5c7ada942a6d1884ab69338f57596f77`.
  - Existing experiment checkout `/home/liubingqi/lbq/IsaacLab` is still present but remains only a read-only reference for this repository.

### Chapter 8 - Isaac Lab Core Workflow

- Official tutorial path mentioned by the book:
  - `scripts/tutorials/02_scene/create_scene.py`
- Official training script:
  - Upstream v2.3.0: `scripts/reinforcement_learning/rsl_rl/train.py`
  - Book command text also uses `scripts/rsl_rl/train.py` in some examples;
    verify against the exact checkout before documenting runnable commands.
- Important source areas:
  - `source/isaaclab/isaaclab/envs/manager_based_env.py`
  - `source/isaaclab/isaaclab/envs/direct_rl_env.py`
  - `source/isaaclab_tasks/isaaclab_tasks/direct/cartpole`
  - `source/isaaclab_tasks/isaaclab_tasks/manager_based/classic/cartpole`
- Remote validation:
  - Chapter 7 uses the clean `v2.3.0` checkout through `PYTHONPATH` when needed.
  - `./isaaclab.sh --help` and `scripts/demos/multi_asset.py --help` pass on `192.168.2.16`.
  - Plain Python still cannot import `carb`, `omni`, or `pxr`; those modules are Isaac Sim Kit runtime modules.
  - Headless `multi_asset.py --num_envs 1` starts Kit but is blocked by `errno=28` file-watch errors on the workstation.

### Chapter 9.2 - Unitree G1 Locomotion

- Book path:
  - `source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion`
- Remote path found:
  - `/home/liubingqi/lbq/IsaacLab/source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion/velocity/config/g1`
- Task registrations found:
  - `Isaac-Velocity-Rough-G1-v0`
  - `Isaac-Velocity-Rough-G1-Play-v0`
  - `Isaac-Velocity-Flat-G1-v0`
  - `Isaac-Velocity-Flat-G1-Play-v0`
- Key files:
  - `rough_env_cfg.py`
  - `flat_env_cfg.py`
  - `agents/rsl_rl_ppo_cfg.py`
  - `velocity_env_cfg.py`
  - `mdp/rewards.py`
  - `mdp/terminations.py`
  - `mdp/curriculums.py`

### Chapter 9.3 - Whole-Body Motion Tracking

- Book says the code is under:
  - `source/unitree_rl_lab/unitree_rl_lab/tasks/mimic`
- Upstream path:
  - `https://github.com/unitreerobotics/unitree_rl_lab/tree/main/source/unitree_rl_lab/unitree_rl_lab/tasks/mimic`
- Remote status:
  - `/home/liubingqi/lbq/unitree_rl_lab` is sparse-checked to `deploy` and
    `resources`.
  - The mimic source path is not present locally on the remote workstation.
- Related upstream sources:
  - BeyondMimic tracking: `https://github.com/HybridRobotics/whole_body_tracking`
  - GMR retargeting: `https://github.com/YanjieZe/GMR`
- Key concepts to explain from code:
  - `MotionLoader`
  - `MotionCommand`
  - anchor-relative observation and reward terms
  - adaptive sampling
  - retargeted motion CSV/NPZ pipeline

### Chapter 10 - Sim-To-Real And Deploy

- Unitree MuJoCo upstream:
  - `https://github.com/unitreerobotics/unitree_mujoco`
- SDK2 upstream:
  - `https://github.com/unitreerobotics/unitree_sdk2`
- Deploy upstream:
  - `https://github.com/unitreerobotics/unitree_rl_lab/tree/main/deploy`
- Remote deploy files found:
  - `/home/liubingqi/lbq/unitree_rl_lab/deploy/robots/g1_29dof/src/State_Mimic.cpp`
  - `/home/liubingqi/lbq/unitree_rl_lab/deploy/robots/g1_29dof/include/State_Mimic.h`
  - `/home/liubingqi/lbq/unitree_rl_lab/deploy/include/isaaclab`
  - `/home/liubingqi/lbq/unitree_rl_lab/deploy/include/FSM`
- Remote unitree_mujoco is dirty and includes local simulation additions.
  Inspect before using it as textbook reference material.

## Initial Validation Notes

Commands were run read-only on `192.168.2.16`.

| Check | Result | Note |
| --- | --- | --- |
| `env_isaaclab_2.3_lbq` exists | pass | Listed by conda |
| `isaacsim==5.1.0.0` installed | pass | `pip show isaacsim` |
| clean IsaacLab checkout | pass | `v2.3.0`, commit `3c6e67bb5c7ada942a6d1884ab69338f57596f77` |
| `multi_asset.py --help` | pass | Runs through `./isaaclab.sh -p` |
| plain Python `carb/omni/pxr` | blocked | Runtime modules are not on normal Python path before Kit startup |
| headless `multi_asset.py` | blocked | Kit starts, then file-watch errors `errno=28`; see chapter evidence |
| G1 locomotion files | pass | Found in remote IsaacLab checkout |
| unitree_rl_lab mimic files | blocked | Upstream path exists, sparse remote checkout lacks `source/` |

## Proposed Organization Work

1. Pin the exact source targets:
   - IsaacLab `v2.3.0`
   - Unitree RL Lab commit used for the book
   - Unitree MuJoCo commit used for the book
   - BeyondMimic and GMR commits used for examples
2. Create clean source mirrors on `192.168.2.16` separate from dirty experiment
   repos, or use git worktrees, before copying explanations into this local
   management workspace.
3. Resolve Isaac Sim `pxr` exposure, then run smoke checks:
   - list/register Isaac Lab environments
   - run headless Cartpole or minimal task help checks
   - run G1 locomotion command with very small `--num_envs` if safe
4. Document each chapter with:
   - source file path
   - key classes/functions
   - data flow
   - runnable command
   - validation result and log path
