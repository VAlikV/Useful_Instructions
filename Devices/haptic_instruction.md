## Установка драйверов и примеров для Haptic

### Скачать с github-репозитория https://github.com/lexand59/3ds_touch_openhaptics установочные скрипты:

- install-3ds-openhaptics-3.4.sh

- install-3ds-touch-drivers-2023.sh


### Запустить скрипты:

```bash
chmod +x <имя_скрипта>.sh
./<имя_скрипта>.sh
```

При необходимости сначала утановить зависимости (о них будет написано в терминале). После установки перезагрузить компьютер

<!-- Copy the executables for Touch Setup and Touch diagnostics from the bin folder to /usr/bin and -->

### Скопировать LibPhantomIOLib42.so в /usr/lib

### Создать директорию 3DSystems:

```bash
sudo mkdir /usr/share/3DSystems
```
### Добавить в переменные среды (/etc/environment) GTDD_HOME:

```bash
GTDD_HOME="/usr/share/3DSystems"
```

Потом перезагрузить систему и проверить
```bash
echo $GTDD_HOME
```

### Создать директорию config:

```bash
sudo mkdir /usr/share/3DSystems/config
sudo chmod 777 /usr/share/3DSystems/config
```

### Подключить Haptic по USB

### Настроить доступ

```bash
sudo chmod 777 /dev/ttyACM0
```
### Добавить устройство

```bash
sudo Touch_HeadlessSetup
```
### Готово