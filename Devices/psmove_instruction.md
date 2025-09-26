## Установка API на ubuntu для PSMove

### Склонировать репозиторий https://github.com/thp/psmoveapi/tree/master

### Установить зависимости

```bash
sudo apt install libdbus-1-dev libudev-dev libbluetooth-dev libusb-1.0-0-dev libusb
```

### Сбилдить через cmake

```bash
mkdir build && cd build
cmake ..
cmake --build .
```

### Подключение

#### Подключить по USB и выполнить:

```bash
./psmove pair
```

#### Отредактировать `/etc/bluetooth/input.cfg`

```bash
ClassicBondedOnly = false
```

### Можно подключать bluetooth

P.S. На Windows все примерно также


