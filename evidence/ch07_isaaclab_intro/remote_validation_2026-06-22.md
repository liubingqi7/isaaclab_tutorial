# 第 7 章远端验证摘要

## 基本信息

```text
host: 192.168.2.16
conda: env_isaaclab_2.3_lbq
source: /home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
tag: v2.3.0
commit: 3c6e67bb5c7ada942a6d1884ab69338f57596f77
```

## 版本检查

```text
isaacsim 5.1.0.0
isaacsim-app 5.1.0.0
isaacsim-core 5.1.0.0
isaacsim-rl 5.1.0.0
torch 2.7.0+cu128
```

## 关键源码文件

```text
FOUND scripts/demos/multi_asset.py
FOUND scripts/tutorials/02_scene/create_scene.py
FOUND scripts/reinforcement_learning/rsl_rl/train.py
FOUND source/isaaclab_tasks/isaaclab_tasks/manager_based/locomotion/velocity/config/g1/__init__.py
```

## 入口检查

`./isaaclab.sh --help`：通过。

`./isaaclab.sh -p scripts/demos/multi_asset.py --help`：通过，能列出 `--num_envs`、`--headless`、`--device` 等参数。

## headless 运行检查

命令：

```bash
timeout 75 ./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1
```

结果：

```text
EXIT_CODE=124
```

日志开头显示 Isaac Sim Kit 已启动：

```text
Loading user config located at: .../isaacsim/kit/data/Kit/Isaac-Sim/5.1/user.config.json
[Info] [carb] Logging to file: .../kit_20260622_182439.log
```

阻塞错误：

```text
errno=28/No space left on device
```

磁盘状态：

```text
/home: 413G available
/media/liubingqi/151a0406-b869-4037-a6b0-16f1dcfb2eb5: 2.7T available
```

inotify 状态：

```text
fs.inotify.max_user_watches: 65536
fs.inotify.max_user_instances: 128
fs.inotify.max_queued_events: 16384
```

判断：磁盘空间充足，`errno=28` 更可能来自 inotify watch 资源不足或被其他进程占用。第 7 章真实 headless demo 需要先处理该系统资源限制。
