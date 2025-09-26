# Autoscript

#### Systemd-сервис

Узнай путь к своему скрипту, например:

```bash
/home/pi/myproject/start.py
```

Убедись, что скрипт запускается вручную:

```bash
python3 /home/pi/myproject/start.py
```

Создай systemd-юнит:

```bash
sudo nano /etc/systemd/system/myscript.service
```

Вставь туда:

```bash
[Unit]
Description=My Python Script
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/pi/myproject/start.py
WorkingDirectory=/home/pi/myproject
StandardOutput=inherit
StandardError=inherit
Restart=always
User=pi

[Install]
WantedBy=multi-user.target
```

Сохрани файл и выполни:

```bash
sudo systemctl daemon-reload
sudo systemctl enable myscript.service
sudo systemctl start myscript.service
```

Проверить статус:

```bash
systemctl status myscript.service
```