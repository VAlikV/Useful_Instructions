## Краткая инструкция по установке системы на Jetson на примере Jetson Nano
### Для других систем отличаются названия, версии и способы перевода в recovery mode

## Подготовка Jetson Nano

### 1. Вставить sd карту

### 2. Установить перемычки:

- Перемычка на выбор питания - J48
- Перемычка на перевод в RECOVERY MODE - FC_REC -> GND

### 3. Подключить к хосту через microUSB

### 4. Включить питание 5В 4А

#### После этого среди подключенных устройств появится устройство NVIDIA

```bash
lsusb
```
Output:
```bash
# *Что-то там* NVIDIA
```

## В ubunta

### 1. Скачать docker-образ SDK manager для Ubunta 18.04 (https://developer.nvidia.com/sdk-manager)

### 1.1. Официальная инструкция (нахой её) https://docs.nvidia.com/sdk-manager/docker-containers/ (можно отдать GPT)
 
### 2. Загрузка контейнера

```bash
docker load -i ./sdkmanager-[версия].[номер_сборки]-[базовая_ОС]_docker.tar.gz

docker tag sdkmanager:[версия].[номер_сборки] sdkmanager:latest
```

### 3. Запустить

```bash
docker run -it --rm --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  -v /dev:/dev \
  -v ~/nvidia/nv_sdkm:/home/nvidia/nv_sdkm \
  --network host \
  sdkmanager:latest \
  --cli install \
  --login-type devzone \
  --product Jetson \
  --version 4.6.6 \
  --targetos Linux \
  --target JETSON_NANO_TARGETS \
  --flash
```

### 4. Далее по инструкции

### 4.1. Возможно понадобится установка:

```bash
sudo apt update
sudo apt install qemu-user-static binfmt-support
```

## Завершение прошивки

### 1. Когда установка скрипт полностью завершится, выключить питание

### 2. Вытащить перемычку FC_REC -> GND

## Можно использовать

### Установка CUDA и прочего

```bash
sudo apt update
sudo apt upgrade
sudo apt install nvidia-jetpack
```