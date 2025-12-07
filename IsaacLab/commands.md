## Примеры разных команд

### Запуск скриптов

```bash

```

### Тест задачи на случайном агенте

```bash
./isaaclab.sh -p scripts/environments/random_agent.py --task Isaac-Tesolo-Delto-Direct-v0
```

### Запуск обучения

```bash
./isaaclab.sh -p scripts/reinforcement_learning/rl_games/train.py --task Isaac-Tesolo-Delto-Direct-v0 --num_envs 1024 --headless
```

#### С логером
```bash
./isaaclab.sh -p scripts/reinforcement_learning/rl_games/train.py --task Isaac-Tesolo-Delto-Direct-v0 --num_envs 1024 --headless --wandb-project-name <name> --wandb-entity <a?> --wandb-name UR10-Tessolo-v0 --track
```

### Запуск TensorBoard

```bash
./isaaclab.sh -p -m tensorboard.main --logdir=logs
```

Флаги:

- `--agent hand_grasp_rlg.yaml`


### Запуск теста обученного агента

```bash
./isaaclab.sh -p scripts/reinforcement_learning/rl_games/play.py --task Isaac-Tesolo-Delto-Direct-v0
```

Флаги:

- `--checkpoint /ABS/PATH/TO/nn/last.pth`
- `--video --video_length 1000 --video_fps 30`