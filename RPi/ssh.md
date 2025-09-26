# SSH connect

```bash
ssh control@192.168.68.242
```

### Copy files

```bash 
rsync -avz control@192.168.68.242:/home/control/Desktop/camera/save/ ~/Downloads/photos_from_pi/
```

# Turn on/off gui

```bash
sudo systemctl start gdm
sudo systemctl stop gdm
```
