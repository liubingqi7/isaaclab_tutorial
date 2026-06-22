# 第 7 章 Isaac Lab 环境与源码结构

本章只整理代码对应关系和运行验证结果，不重复书中的概念讲解。

## 代码来源

| 项目 | 版本 | 路径 |
| --- | --- | --- |
| Isaac Lab | `v2.3.0` | `/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0` |
| Isaac Lab commit | `3c6e67bb5c7ada942a6d1884ab69338f57596f77` | 同上 |
| Isaac Sim | `5.1.0.0` | `env_isaaclab_2.3_lbq` |
| 运行机器 | `192.168.2.16` | `liubingqi@192.168.2.16` |

已有实验目录 `/home/liubingqi/lbq/IsaacLab` 不是书中版本，且存在未跟踪文件。本章使用上表中的干净源码目录。

## 书中对应

| 书中位置 | 对应源码 | 用途 |
| --- | --- | --- |
| 7.2 Isaac Lab 开发环境搭建 | `isaaclab.sh` | 安装扩展、运行 Python、启动模拟器。 |
| 7.2.3 验证与测试 | `scripts/demos/multi_asset.py` | 书中安装验证 demo。 |
| 7.3 项目结构 | `source/` | Isaac Lab 扩展源码。 |
| 7.3 项目结构 | `scripts/` | demo、tutorial、训练和工具入口。 |

## 代码结构

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

运行链路：

```text
isaaclab.sh
  -> Conda Python / Isaac Sim Kit
  -> scripts/demos/multi_asset.py
  -> AppLauncher
  -> source/isaaclab 中的 sim、assets、scene 接口
```

## 运行与测试

进入环境：

```bash
ssh liubingqi@192.168.2.16
source ~/miniconda3/etc/profile.d/conda.sh
conda activate env_isaaclab_2.3_lbq
cd /home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
```

版本检查：

```bash
git describe --tags --always --dirty
git rev-parse HEAD
python -m pip show isaacsim isaacsim-app isaacsim-core isaacsim-rl
```

已验证结果：

```text
Isaac Lab: v2.3.0
commit: 3c6e67bb5c7ada942a6d1884ab69338f57596f77
isaacsim: 5.1.0.0
torch: 2.7.0+cu128
```

入口检查：

```bash
./isaaclab.sh --help
./isaaclab.sh -p scripts/demos/multi_asset.py --help
```

结果：两条命令均通过，`multi_asset.py` 能列出 `--num_envs`、`--headless`、`--device` 等参数。

实际 headless 小规模运行：

```bash
timeout 75 ./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1
```

当前结果：Isaac Sim Kit 能开始启动，但 75 秒内未完成，日志中反复出现：

```text
errno=28/No space left on device
```

磁盘空间充足：

```text
/home: 413G available
/media/liubingqi/151a0406-b869-4037-a6b0-16f1dcfb2eb5: 2.7T available
```

因此该阻塞更像 inotify 文件监控资源限制，而不是磁盘不足。当前系统值：

```text
fs.inotify.max_user_watches: 65536
fs.inotify.max_user_instances: 128
fs.inotify.max_queued_events: 16384
```

补充说明：普通 Python 下 `carb`、`omni`、`pxr` 不可见；它们是 Isaac Sim Kit 运行时模块，需由 Kit / SimulationApp 启动后注入。当前远端脚本会记录这一点。

一键检查：

```bash
tools/remote/check_ch07_isaaclab.sh
```
