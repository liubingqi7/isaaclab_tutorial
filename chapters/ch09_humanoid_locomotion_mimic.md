# 第 9 章 人形机器人 Locomotion 与动作追踪

本章对应书中 Unitree G1 人形机器人控制实战。代码整理分为两部分：Isaac Lab 官方 G1 速度指令 locomotion，以及 `unitree_rl_lab` 中的 G1 locomotion / mimic 任务。

## 代码来源

| 项目 | 仓库 |
| --- | --- |
| Isaac Lab | `https://github.com/isaac-sim/IsaacLab.git` |
| unitree_rl_lab | `https://github.com/unitreerobotics/unitree_rl_lab.git` |
| BeyondMimic | `https://beyondmimic.github.io/` |

BeyondMimic 在本章中主要作为全身动作追踪思路的参考。实际可运行源码以 Isaac Lab 和 `unitree_rl_lab` 为主。

## 书中代码对应关系

| 书中内容 | 对应源码 | 作用 |
| --- | --- | --- |
| G1 locomotion 场景与任务 | `source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion/velocity/config/g1/` | Isaac Lab 官方 G1 速度指令任务配置。 |
| G1 locomotion MDP | `source/unitree_rl_lab/unitree_rl_lab/tasks/locomotion/` | Unitree 版本的 locomotion 任务、奖励、观测和命令。 |
| G1 mimic 任务 | `source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/` | 全身动作追踪任务。 |
| 动作数据 | `source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/robots/g1_29dof/*/*.csv` | 重定向后的参考动作序列。 |
| mimic 训练配置 | `source/unitree_rl_lab/unitree_rl_lab/tasks/mimic/agents/rsl_rl_ppo_cfg.py` | RSL-RL PPO 超参数。 |

## 源码骨架

```text
unitree_rl_lab/
├── scripts/rsl_rl/
│   ├── train.py
│   └── play.py
└── source/unitree_rl_lab/unitree_rl_lab/tasks/
    ├── locomotion/
    │   ├── mdp/
    │   └── robots/g1/29dof/velocity_env_cfg.py
    └── mimic/
        ├── mdp/
        ├── agents/rsl_rl_ppo_cfg.py
        └── robots/g1_29dof/
            ├── dance_102/tracking_env_cfg.py
            └── gangnanm_style/tracking_env_cfg.py
```

`locomotion` 任务以速度指令为目标，重点是地形、基座速度、足端接触、关节正则和姿态稳定。`mimic` 任务以参考动作为目标，核心是 `MotionLoader` 和 command term：前者管理离线动作序列，后者在并行环境中采样参考帧并生成观测、奖励和重置状态。

## 准备源码

```bash
scripts/ch09/setup_unitree_rl_lab.sh ~/isaaclab_sources/unitree_rl_lab
```

如果已经有源码目录，可以直接运行检查：

```bash
scripts/ch09/check_unitree_rl_lab.sh ~/isaaclab_sources/unitree_rl_lab
```

## 运行入口

Isaac Lab 官方 G1 rough terrain locomotion：

```bash
cd ~/isaaclab_sources/IsaacLab-v2.3.0
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/train.py \
  --task Isaac-Velocity-Rough-G1-v0 \
  --headless
```

unitree_rl_lab G1 mimic dance：

```bash
cd ~/isaaclab_sources/unitree_rl_lab
python scripts/rsl_rl/train.py \
  --task Unitree-G1-29dof-Mimic-Dance-102 \
  --headless
```

回放策略时使用同目录下的 `scripts/rsl_rl/play.py`。训练与回放命令都依赖 Isaac Lab/Isaac Sim 环境，运行前应先激活书中配置的 Conda 环境。
