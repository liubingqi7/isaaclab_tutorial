# 第 7 章补充说明

这里只记录与代码运行直接相关的补充点。

## 1. 普通 Python 与 Isaac Sim Kit Python 的差异

`env_isaaclab_2.3_lbq` 中安装了 Isaac Sim pip 包，但 `carb`、`omni`、`pxr` 并不是普通 Python 启动时天然可见的模块。它们位于 Isaac Sim 的 extension cache 中，通常在 Kit / SimulationApp 启动后进入运行时路径。

因此，本章验证分为两类：

- 普通入口检查：`./isaaclab.sh --help`、`multi_asset.py --help`。
- Kit 启动检查：`multi_asset.py --headless --num_envs 1`。

## 2. 为什么使用干净源码区

已有 `/home/liubingqi/lbq/IsaacLab` 是 `v2.2.1-199-g0aa7837e3a`，且有未跟踪文件。书中使用 IsaacLab `v2.3.0`，所以配套仓库使用：

```text
/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0
```

这样可以避免把旧版本或实验改动混入教材配套代码。

## 3. 当前阻塞项

`multi_asset.py` 的 headless 运行被 `errno=28/No space left on device` 阻塞。远端磁盘仍有空间，因此重点应检查 inotify watch 使用情况或提高系统限制。
