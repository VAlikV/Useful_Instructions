# Запуск ROS2 в докер

```bash
docker pull osrf/ros:humble-desktop-full

xhost +local:docker

docker run -it \
  --rm \
  --net=host \
  --privileged \
  --env="DISPLAY=$DISPLAY" \
  --env="QT_X11_NO_MITSHM=1" \
  --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
  --volume="$HOME/ros2_ws:/root/ros2_ws" \
  --workdir="/root/ros2_ws" \
  osrf/ros:humble-desktop-full \
  bash
```

## Начало

```bash
source /opt/ros/humble/setup.bash

colcon build
source install/setup.bash

# Пример:
ros2 run demo_nodes_cpp talker
```

## Для своего проекта

```Dockerfile
FROM osrf/ros:humble-desktop-full

# Install dependencies
RUN apt update && apt install -y \
    python3-colcon-common-extensions \
    ros-humble-rqt* \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
RUN mkdir -p /root/ros2_ws/src
WORKDIR /root/ros2_ws

```

