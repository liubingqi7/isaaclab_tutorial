# 第 7 章测试记录

测试时间：2026-06-22。

## 测试环境

| 项目 | 值 |
| --- | --- |
| 远端机器 | `192.168.2.16` |
| Conda 环境 | `env_isaaclab_2.3_lbq` |
| IsaacLab 路径 | `/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0` |
| IsaacLab 版本 | `v2.3.0` |
| IsaacLab commit | `3c6e67bb5c7ada942a6d1884ab69338f57596f77` |
| Isaac Sim | `5.1.0.0` |
| Torch | `2.7.0+cu128` |

## 结果表

| 检查项 | 命令 | 结果 | 说明 |
| --- | --- | --- | --- |
| 干净源码区 | `git describe --tags --always --dirty` | 通过 | 输出 `v2.3.0`。 |
| 关键文件存在 | `test -f scripts/demos/multi_asset.py` 等 | 通过 | `multi_asset.py`、`create_scene.py`、`rsl_rl/train.py`、G1 task 注册文件均存在。 |
| Isaac Sim 包 | `python -m pip show isaacsim` | 通过 | `isaacsim==5.1.0.0`。 |
| IsaacLab 入口 | `./isaaclab.sh --help` | 通过 | 能输出入口脚本帮助。 |
| demo 参数入口 | `./isaaclab.sh -p scripts/demos/multi_asset.py --help` | 通过 | 能输出 `multi_asset.py` 参数帮助。 |
| 普通 Python 导入 `pxr` | `importlib.util.find_spec("pxr")` | 未通过 | `pxr` 不在普通 Python 的 `sys.path` 中。该模块位于 Isaac Sim extension cache，通常由 Kit 启动后注入。 |
| 普通 Python 导入 `carb/omni` | `import isaaclab_assets`、`import isaaclab_tasks` | 未通过 | 报 `No module named 'carb'` 或 `No module named 'omni'`，原因同上。 |
| headless demo 小规模启动 | `timeout 75 ./isaaclab.sh -p scripts/demos/multi_asset.py --headless --num_envs 1` | 阻塞 | Kit 开始加载，但大量 `errno=28/No space left on device` 文件监控错误，75 秒内未完成启动。 |

## 日志位置

远端日志：

```text
/home/liubingqi/lbq/isaaclab_tutorial_sources/logs/ch07/multi_asset_headless_help_or_run.log
```

本仓库摘要：

```text
evidence/ch07_isaaclab_intro/remote_validation_2026-06-22.md
```

## 当前结论

第 7 章源码定位、版本固定、入口脚本、demo 参数入口均已通过。实际 headless demo 已进入 Isaac Sim Kit 启动阶段，但当前机器的文件监控资源限制导致启动未在 75 秒内完成。后续若要完成真实仿真画面验证，应先调整或释放 inotify watch 资源，再重跑同一命令。
