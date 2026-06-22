# 第 7 章代码结构索引

本章只整理 IsaacLab 仓库的顶层结构和安装验证相关入口。后续章节会继续深入任务、训练和部署代码。

## IsaacLab 顶层结构

```text
IsaacLab-v2.3.0/
├── isaaclab.sh
├── apps/
├── scripts/
│   ├── demos/
│   │   └── multi_asset.py
│   ├── tutorials/
│   └── reinforcement_learning/
│       └── rsl_rl/
└── source/
    ├── isaaclab/
    ├── isaaclab_assets/
    ├── isaaclab_tasks/
    ├── isaaclab_rl/
    └── isaaclab_mimic/
```

## 入口关系

```text
用户命令
  ↓
isaaclab.sh
  ↓
Conda Python / Isaac Sim Kit
  ↓
scripts/demos/multi_asset.py
  ↓
AppLauncher 启动 Isaac Sim
  ↓
source/isaaclab 中的 sim、assets、scene 接口
```

## 本章关注点

| 模块 | 本章作用 | 后续章节关系 |
| --- | --- | --- |
| `isaaclab.sh` | 统一运行入口。第 7 章先确认它能识别环境和脚本参数。 | 第 8、9 章训练命令仍通过它或同类入口运行。 |
| `scripts/demos/multi_asset.py` | 安装验证 demo。 | 用于确认 AppLauncher、资产加载和多环境场景创建可进入。 |
| `source/isaaclab` | 核心 API。 | 第 8 章环境、场景、MDP 管理器会展开。 |
| `source/isaaclab_tasks` | 官方任务集合。 | 第 8 章 Cartpole 和第 9 章 G1 locomotion 会展开。 |
| `source/isaaclab_assets` | 机器人和资产配置。 | 第 9 章 G1 资产配置会继续使用。 |

## 当前远端源码状态

```text
host: 192.168.2.16
path: /home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
tag: v2.3.0
commit: 3c6e67bb5c7ada942a6d1884ab69338f57596f77
status: clean
```
