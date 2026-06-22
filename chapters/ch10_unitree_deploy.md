# 第 10 章 Unitree 软件在环与部署

本章对应书中 `unitree_mujoco` 与 `unitree_rl_lab/deploy` 的部署流程。目标是把 Isaac Lab 中训练出的策略，放到更接近真机接口的 MuJoCo + SDK2 闭环中验证。

## 代码来源

| 项目 | 仓库 |
| --- | --- |
| unitree_mujoco | `https://github.com/unitreerobotics/unitree_mujoco.git` |
| unitree_rl_lab | `https://github.com/unitreerobotics/unitree_rl_lab.git` |
| unitree_sdk2 | `https://github.com/unitreerobotics/unitree_sdk2.git` |

## 书中代码对应关系

| 书中内容 | 对应源码 | 作用 |
| --- | --- | --- |
| MuJoCo 接口级仿真 | `unitree_mujoco/simulate/` | 加载机器人模型，桥接 MuJoCo 与 Unitree SDK2 消息。 |
| G1 模型与场景 | `unitree_mujoco/unitree_robots/g1/` | G1 XML、mesh、scene 文件。 |
| SDK2 桥接 | `unitree_mujoco/simulate/src/unitree_sdk2_bridge.h` | LowCmd / LowState 通信接口。 |
| deploy 状态机 | `unitree_rl_lab/deploy/include/FSM/` | Passive、FixStand、RL 等状态组织。 |
| Isaac Lab C++ 复现 | `unitree_rl_lab/deploy/include/isaaclab/` | action、observation、manager 等部署侧接口。 |
| G1 29DoF 部署任务 | `unitree_rl_lab/deploy/robots/g1_29dof/` | 配置、入口和 mimic 状态实现。 |

## 源码骨架

```text
unitree_mujoco/
├── simulate/
│   ├── CMakeLists.txt
│   └── src/
│       ├── main.cc
│       └── unitree_sdk2_bridge.h
└── unitree_robots/g1/
    ├── g1_29dof.xml
    └── scene_29dof.xml

unitree_rl_lab/deploy/
├── include/
│   ├── FSM/
│   └── isaaclab/manager/
└── robots/g1_29dof/
    ├── CMakeLists.txt
    ├── config/config.yaml
    ├── main.cpp
    └── src/State_Mimic.cpp
```

`unitree_mujoco` 是虚拟硬件层，负责发布 `LowState` 并接收 `LowCmd`。`deploy` 是策略控制层，负责读取状态、构造观测、执行 ONNX 策略、生成关节目标，并通过 SDK2 写回控制命令。

## 准备源码

```bash
scripts/ch09/setup_unitree_rl_lab.sh ~/isaaclab_sources/unitree_rl_lab
scripts/ch10/setup_unitree_mujoco.sh ~/isaaclab_sources/unitree_mujoco
```

检查源码结构：

```bash
scripts/ch10/check_unitree_deploy.sh \
  ~/isaaclab_sources/unitree_mujoco \
  ~/isaaclab_sources/unitree_rl_lab
```

## 构建入口

构建 `unitree_mujoco`：

```bash
cd ~/isaaclab_sources/unitree_mujoco/simulate
mkdir -p build
cd build
cmake ..
make -j
```

构建 G1 29DoF deploy 控制程序：

```bash
cd ~/isaaclab_sources/unitree_rl_lab/deploy/robots/g1_29dof
mkdir -p build
cd build
cmake ..
make -j
```

当前版本中，G1 deploy 的可执行文件名为 `g1_ctrl`。

## 运行入口

终端 1 启动虚拟硬件：

```bash
cd ~/isaaclab_sources/unitree_mujoco/simulate/build
./unitree_mujoco -r g1 -s scene_29dof.xml
```

终端 2 启动部署控制程序：

```bash
cd ~/isaaclab_sources/unitree_rl_lab/deploy/robots/g1_29dof/build
./g1_ctrl <network_interface>
```

`<network_interface>` 需要替换为本机实际网卡名，例如 `eth0`、`enp3s0` 或 `wlan0`。真实机器人部署前，应先在 MuJoCo 软件在环中确认策略、关节映射、PD 参数和观测维度一致。
