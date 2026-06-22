# Isaac Lab Tutorial

本仓库是《具身智能仿真实战：构建、训练与部署》中 Isaac Lab 相关内容的配套源码仓库。

书中负责讲清楚概念、原理和实验背景；本仓库负责整理对应源码、运行入口和最小验证步骤。读者可以按照章节进入相应目录，快速定位书中提到的代码。

## 章节索引

| 章节 | 内容 | 说明 |
| --- | --- | --- |
| [第 7 章](chapters/ch07_isaaclab_intro.md) | Isaac Lab 环境与源码结构 | 已整理 |
| 第 8 章 | Isaac Lab 任务与强化学习入口 | 待整理 |
| 第 9 章 | 人形机器人 locomotion 与动作追踪 | 待整理 |
| 第 10 章 | Unitree 部署与 sim-to-real 流程 | 待整理 |

## 仓库结构

```text
isaaclab_tutorial/
├── README.md
├── chapters/
│   └── ch07_isaaclab_intro.md
└── scripts/
    └── ch07/
        ├── setup_isaaclab_v2_3.sh
        └── check_isaaclab_install.sh
```

## 环境约定

第 7 章以 Isaac Lab `v2.3.0` 为准，对应 Isaac Sim `5.1.0` 和 Python `3.11`。如果已经按照书中方式配置好 Conda 环境，可以直接进入该环境；如果环境名称不同，只需保证 Isaac Sim 与 Isaac Lab 版本匹配即可。

```bash
conda activate env_isaaclab_2.3_lbq
```

## 快速开始

```bash
scripts/ch07/setup_isaaclab_v2_3.sh ~/isaaclab_sources/IsaacLab-v2.3.0
conda activate env_isaaclab_2.3_lbq
scripts/ch07/check_isaaclab_install.sh ~/isaaclab_sources/IsaacLab-v2.3.0
```

源码准备完成后，进入 Isaac Lab 目录运行书中的安装验证 demo：

```bash
cd ~/isaaclab_sources/IsaacLab-v2.3.0
./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1
```
