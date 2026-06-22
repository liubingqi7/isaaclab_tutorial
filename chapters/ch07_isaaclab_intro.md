# 第 7 章 Isaac Lab 环境与源码结构

本章对应书中 Isaac Lab 环境搭建、安装验证和源码结构阅读部分。这里不重复书中的原理讲解，只整理源码位置、运行入口和检查方法。

## 代码来源

| 项目 | 版本 |
| --- | --- |
| Isaac Lab | `v2.3.0` |
| Isaac Lab tag commit | `3c6e67bb5c7ada942a6d1884ab69338f57596f77` |
| Isaac Sim | `5.1.0` |
| Python | `3.11` |

Isaac Lab 官方源码仓库：

```text
https://github.com/isaac-sim/IsaacLab.git
```

本章脚本默认把源码准备到 `~/isaaclab_sources/IsaacLab-v2.3.0`。读者也可以指定自己的目录。

## 书中代码对应关系

| 书中内容 | 对应源码 | 作用 |
| --- | --- | --- |
| Isaac Lab 开发环境搭建 | `isaaclab.sh` | 安装扩展、调用 Python、进入 Isaac Sim Kit 运行时。 |
| 安装验证 demo | `scripts/demos/multi_asset.py` | 加载多类资产，验证仿真、场景和可视化链路。 |
| 项目源码结构 | `source/` | Isaac Lab 的核心扩展包。 |
| 示例与训练入口 | `scripts/` | demos、tutorials、强化学习训练脚本和工具脚本。 |

## 源码骨架

```text
IsaacLab-v2.3.0/
├── isaaclab.sh
├── scripts/
│   ├── demos/multi_asset.py
│   ├── tutorials/02_scene/create_scene.py
│   └── reinforcement_learning/rsl_rl/train.py
└── source/
    ├── isaaclab
    ├── isaaclab_assets
    ├── isaaclab_tasks
    ├── isaaclab_rl
    └── isaaclab_mimic
```

阅读时可以先抓住一条主线：

```text
isaaclab.sh
  -> Isaac Sim / Kit Python
  -> AppLauncher
  -> SimulationContext
  -> scene、asset、sensor、env 等 Isaac Lab 接口
```

`isaaclab.sh` 是入口。它把普通 shell 命令转换为 Isaac Lab 可以使用的 Python 运行环境。`scripts/demos/multi_asset.py` 则是第七章最适合做安装验证的脚本，因为它同时覆盖了应用启动、资产加载、场景创建和仿真循环。

## 本仓库脚本

准备 Isaac Lab 源码：

```bash
scripts/ch07/setup_isaaclab_v2_3.sh ~/isaaclab_sources/IsaacLab-v2.3.0
```

检查当前环境和关键入口：

```bash
conda activate env_isaaclab_2.3_lbq
scripts/ch07/check_isaaclab_install.sh ~/isaaclab_sources/IsaacLab-v2.3.0
```

检查脚本会确认三类内容：

1. 当前源码是否为 Isaac Lab `v2.3.0`。
2. `source/` 和 `scripts/` 中的关键文件是否存在。
3. `isaaclab.sh` 与 `multi_asset.py` 的命令行入口是否可用。

## 运行验证

进入 Isaac Lab 源码目录：

```bash
cd ~/isaaclab_sources/IsaacLab-v2.3.0
```

查看总入口：

```bash
./isaaclab.sh --help
```

查看第七章验证 demo 的参数：

```bash
./isaaclab.sh -p scripts/demos/multi_asset.py --help
```

小规模 headless 运行：

```bash
./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1
```

如果 `--help` 能正常输出，说明 Isaac Lab 的 Python 入口、脚本路径和依赖发现基本正确。真正启动仿真时还会继续检查 GPU、驱动、Isaac Sim Kit 缓存和图形后端，因此它比命令行入口检查更依赖机器环境。

## 补充说明

`carb`、`omni`、`pxr` 等模块属于 Isaac Sim Kit 运行时。它们通常不能在普通 Python 解释器中直接导入，需要通过 `isaaclab.sh` 或 `SimulationApp` 启动 Kit 后才会出现在运行环境中。因此，第七章的验证应以 `isaaclab.sh` 和示例脚本为入口，而不是只用普通 `python -c "import omni"` 判断环境是否正确。
