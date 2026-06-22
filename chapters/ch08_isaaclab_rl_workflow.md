# 第 8 章 Isaac Lab 强化学习工作流

本章对应书中“从强化学习环境构建到端到端训练”的内容。代码整理以 Isaac Lab `v2.3.0` 为准。

## 代码来源

| 项目 | 版本或仓库 |
| --- | --- |
| Isaac Lab | `v2.3.0` |
| Isaac Lab 官方仓库 | `https://github.com/isaac-sim/IsaacLab.git` |
| RSL-RL | `https://github.com/leggedrobotics/rsl_rl` |

## 书中代码对应关系

| 书中内容 | 对应源码 | 作用 |
| --- | --- | --- |
| 仿真应用与生命周期 | `source/isaaclab/isaaclab/app/` | 启动 Isaac Sim Kit，管理应用参数。 |
| 直接式工作流 | `source/isaaclab/isaaclab/envs/direct_rl_env.py` | 用继承方式实现单体 RL 环境。 |
| 管理者式工作流 | `source/isaaclab/isaaclab/envs/manager_based_rl_env.py` | 用 scene、action、observation、reward、termination 等 manager 组合任务。 |
| Cartpole 示例 | `source/isaaclab_tasks/isaaclab_tasks/direct/cartpole/` | 直接式任务示例。 |
| RSL-RL 训练入口 | `scripts/reinforcement_learning/rsl_rl/train.py` | 通用 PPO 训练脚本。 |
| RSL-RL 回放入口 | `scripts/reinforcement_learning/rsl_rl/play.py` | 加载 checkpoint 并评估策略。 |

## 源码骨架

```text
IsaacLab-v2.3.0/
├── scripts/reinforcement_learning/rsl_rl/
│   ├── train.py
│   └── play.py
├── source/isaaclab/isaaclab/envs/
│   ├── direct_rl_env.py
│   ├── manager_based_env.py
│   └── manager_based_rl_env.py
└── source/isaaclab_tasks/isaaclab_tasks/
    ├── direct/cartpole/
    └── manager_based/locomotion/velocity/
```

第 8 章可以按两条线阅读。第一条线是环境接口：`DirectRLEnv` 适合把任务逻辑集中写在一个环境类中；`ManagerBasedRLEnv` 适合把动作、观测、奖励、终止条件和事件拆成配置项。第二条线是训练入口：`train.py` 负责解析任务 ID、创建环境、加载算法配置、启动 RSL-RL runner。

## 检查脚本

```bash
scripts/ch08/check_isaaclab_rl.sh ~/isaaclab_sources/IsaacLab-v2.3.0
```

该脚本检查第 8 章涉及的关键文件，并调用 RSL-RL 训练入口的 `--help`，确认命令行接口可用。

## 运行入口

查看训练脚本参数：

```bash
cd ~/isaaclab_sources/IsaacLab-v2.3.0
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/train.py --help
```

以 Cartpole 任务做小规模训练验证：

```bash
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/train.py \
  --task Isaac-Cartpole-Direct-v0 \
  --headless \
  --num_envs 128
```

训练日志默认写入 `logs/rsl_rl/`。如需观察曲线，可使用：

```bash
tensorboard --logdir logs/rsl_rl
```
