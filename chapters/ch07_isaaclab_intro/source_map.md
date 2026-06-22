# 第 7 章源码对应表

本章对应书中第 7 章“Isaac Lab：面向具身智能的下一代仿真生态”。本仓库不复制完整 IsaacLab 源码，只记录与本章代码结构和运行验证直接相关的文件。

## 版本与源码

| 项目 | 版本 | 远端路径 | 上游地址 |
| --- | --- | --- | --- |
| Isaac Lab | v2.3.0 | `/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0` | `https://github.com/isaac-sim/IsaacLab` |
| Isaac Sim | 5.1.0.0 | `env_isaaclab_2.3_lbq` | NVIDIA PyPI |
| Python | 3.11 | `env_isaaclab_2.3_lbq` | Conda |

远端机器：`192.168.2.16`。

## 小节到源码的对应

| 书中小节 | 代码位置 | 作用 |
| --- | --- | --- |
| 7.2 Isaac Lab 开发环境搭建 | `isaaclab.sh` | IsaacLab 的统一入口脚本，负责安装扩展、运行 Python、启动模拟器和创建 Conda 环境。 |
| 7.2.3 验证与测试 | `scripts/demos/multi_asset.py` | 书中用于验证 IsaacLab 安装的多资产并行仿真示例。 |
| 7.3 项目结构与端到端开发流程 | `source/` | IsaacLab 扩展源码目录，每个子目录是一个可安装扩展包。 |
| 7.3 项目结构与端到端开发流程 | `scripts/` | 可直接运行的脚本入口，包括 demo、tutorial、训练和工具脚本。 |
| 7.3 source 目录 | `source/isaaclab` | IsaacLab 核心接口，包含 app、sim、assets、scene、envs 等模块。 |
| 7.3 source 目录 | `source/isaaclab_assets` | 常用机器人与资产配置。 |
| 7.3 source 目录 | `source/isaaclab_tasks` | 官方任务集合。第 9 章 G1 locomotion 也从这里继续展开。 |
| 7.3 source 目录 | `source/isaaclab_rl` | 与 RSL-RL、RL-Games、SKRL、SB3 等强化学习库的适配层。 |
| 7.3 source 目录 | `source/isaaclab_mimic` | 模仿学习相关接口。 |

## 本章关键命令

```bash
ssh liubingqi@192.168.2.16
source ~/miniconda3/etc/profile.d/conda.sh
conda activate env_isaaclab_2.3_lbq
cd /home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
./isaaclab.sh --help
./isaaclab.sh -p scripts/demos/multi_asset.py --help
```

实际仿真启动命令：

```bash
./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1
```

当前验证状态见 `tests.md`。
