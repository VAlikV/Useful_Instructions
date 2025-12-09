## Запуск YOLO в контейнере на Jetson

Самый удобный вариант - docker

### Скачать Dockerfile
```bash 
https://github.com/ultralytics/ultralytics/tree/main/docker
```

### Билд и запуск

```bash
sudo docker build -f Dockerfile-jetson-jetpack4 -t yolo-jetson .

sudo docker run --rm -it \
    --runtime nvidia \
    --ipc=host \
    --network host \
    -v /home/user/myproject:/workspace \
    --device /dev/video0:/dev/video0 \
    yolo-jetson \
    bash
```

Внутри контейнера можно запускать python и скрипты, которые подключены в директории myproject

### Запуск терминала в контейнере

```bash
docker ps # Чтобы узнайть id

sudo docker exec -it <container_name_or_id> bash
```

### Остановка и удаление 

```bash
sudo docker stop <container_name_or_id>
sudo docker rm <container_name_or_id>
sudo docker container prune

# docker images

sudo docker rmi <image_name_or_id>
sudo docker system prune
```