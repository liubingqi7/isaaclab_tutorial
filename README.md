# Isaac Lab Tutorial

本仓库整理《具身智能仿真实战：构建、训练与部署》中 Isaac Lab 相关代码。

重点不是重写书中讲解，而是把代码结构、章节对应关系、运行命令和测试结果整理清楚。
主要源码和计算资源在 `liubingqi@192.168.2.16`，使用 Conda 环境 `env_isaaclab_2.3_lbq`。

## 目录

- `chapters/ch07_isaaclab_intro/`：第 7 章 Isaac Lab 环境与项目结构。
- `evidence/ch07_isaaclab_intro/`：第 7 章远端验证证据。
- `tools/remote/`：远端检查脚本。
- `workspace_manifest.yaml`：远端路径、上游源码和当前验证状态。
- `docs/isaaclab_source_map.md`：全书 Isaac Lab 部分的源码总索引。

## 第 7 章当前状态

- IsaacLab 干净源码：`/home/liubingqi/lbq/isaaclab_tutorial_sources/IsaacLab-v2.3.0`
- IsaacLab 版本：`v2.3.0`
- IsaacLab commit：`3c6e67bb5c7ada942a6d1884ab69338f57596f77`
- Isaac Sim 版本：`5.1.0.0`
- 入口检查：通过
- `multi_asset.py --help`：通过
- `multi_asset.py --headless --num_envs 1`：已启动 Kit，但被 `errno=28` 文件监控资源问题阻塞

运行第 7 章检查：

```bash
tools/remote/check_ch07_isaaclab.sh
```
