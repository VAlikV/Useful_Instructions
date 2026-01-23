## Права для доступа к устройствам /dev/ttyUSB*

Чтобы не требовалось `sudo` для работы с устройствами /dev/ttyUSB*: 

## 1. Добавить пользователя в группу dialout

```bash
ls -l /dev/ttyUSB0
```
Обычно так:

```bash
crw-rw---- 1 root dialout 188, 0 Dec 24 14:20 /dev/ttyUSB0
```

Добавить пользователя в группу `dialout`:

```bash
sudo usermod -aG dialout $USER
```

Выйти и войти в систему, чтобы изменения вступили в силу.

Проверка:

```bash
groups
```

В списке должна быть `dialout`

## 2. Cоздание постоянное udev-правило


1. Узнать VID и PID устройства:

    ```bash
    lsusb
    ```

    Пример:

    ```bash
    Bus 003 Device 005: ID 1a86:7523 QinHeng Electronics HL-340 USB-Serial adapter
    ```

    VID = 1a86

    PID = 7523

2. Создать udev-правило:

    ```bash
    sudo nano /etc/udev/rules.d/99-ch340.rules
    ```

    Вставить:

    ```txt
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE="0666"
    ```

    Для всех пользователей:

    ```txt
    SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE="0660", GROUP="dialout"
    ```

3. Применить изменения:

    ```bash
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    ```
