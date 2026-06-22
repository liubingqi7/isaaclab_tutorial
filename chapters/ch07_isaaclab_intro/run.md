# 第 7 章运行命令

本章命令均在 `192.168.2.16` 上运行。

## 1. 进入环境

```bash
ssh liubingqi@192.168.2.16
source ~/miniconda3/etc/profile.d/conda.sh
conda activate env_isaaclab_2.3_lbq
cd /home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
```

## 2. 确认源码版本

```bash
git describe --tags --always --dirty
git rev-parse HEAD
git status --short
```

预期结果：

```text
v2.3.0
3c6e67bb5c7ada942a6d1884ab69338f57596f77
```

`git status --short` 应为空。

## 3. 确认 Isaac Sim 包版本

```bash
python -m pip show isaacsim isaacsim-app isaacsim-core isaacsim-rl
```

预期结果：版本均为 `5.1.0.0`。

## 4. 运行 IsaacLab 入口帮助

```bash
./isaaclab.sh --help
```

该命令只检查入口脚本，不启动仿真。

## 5. 运行 `multi_asset.py` 参数帮助

```bash
./isaaclab.sh -p scripts/demos/multi_asset.py --help
```

该命令确认 `scripts/demos/multi_asset.py` 能被 Python 入口识别，并能列出 `--num_envs`、`--headless`、`--device` 等参数。

## 6. 运行 headless 小规模验证

```bash
export IL_SRC=$PWD/source
export PYTHONPATH=$IL_SRC/isaaclab:$IL_SRC/isaaclab_assets:$IL_SRC/isaaclab_tasks:$IL_SRC/isaaclab_rl:$IL_SRC/isaaclab_mimic:$PYTHONPATH
mkdir -p /home/liubingqi/lbq/isaaclab_tutorial_sources/logs/ch07
timeout 75 ./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1 \
  > /home/liubingqi/lbq/isaaclab_tutorial_sources/logs/ch07/multi_asset_headless_help_or_run.log 2>&1
```

当前结果：`timeout` 返回 `124`。日志显示 Isaac Sim Kit 已开始加载，但被大量文件监控错误阻塞：

```text
errno=28/No space left on device
```

磁盘仍有空间，当前更像 inotify watch 限制或已占用实例不足：

```text
/home: 413G available
/media/liubingqi/151a0406-b869-4037-a6b0-16f1dcfb2eb5: 2.7T available
fs.inotify.max_user_watches: 65536
fs.inotify.max_user_instances: 128
fs.inotify.max_queued_events: 16384
```

## 7. 一键检查脚本

本仓库提供本章检查脚本：

```bash
tools/remote/check_ch07_isaaclab.sh
```

默认远端为 `liubingqi@192.168.2.16`，默认源码路径为：

```text
/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
```
