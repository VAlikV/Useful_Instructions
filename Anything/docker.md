# Основные команды для docker

docker image list

docker run -it -d <name>

docker ps

docker ps -a

docker exec -it <conteiner_id> bash

docker rm <conteiner_id>

docker rmi <image_id>

docker restart <conteiner_id>

docker stop <conteiner_id>

docker start <conteiner_id>

sudo docker cp <conteiner_id>:/usr/local/apache2/logs/httpd.pid /home/geekflare/