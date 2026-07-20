# Сборка Unity ROS Teleoperation для Meta Quest 3 и запуск ROS 2-моста

## 1. Назначение

Этот документ описывает запуск системы телеуправления на базе проекта:

```text
leggedrobotics/unity_ros_teleoperation
```

Система состоит из трёх частей:

```text
Windows PC
├── Unity Editor
└── сборка и установка APK
          │ USB
          ▼
Meta Quest 3
├── OpenXR
├── отслеживание контроллеров
├── отслеживание кистей
└── ROS-TCP-Connector
          │ Wi-Fi / TCP, порт 10000
          ▼
Ubuntu PC или компьютер робота
├── ROS 2
└── ROS-TCP-Endpoint
```

Windows нужен только для сборки Unity-приложения и установки APK. ROS 2 может работать на отдельном компьютере с Ubuntu.

---

## 2. Проверенная конфигурация

| Компонент | Значение |
|---|---|
| VR-шлем | Meta Quest 3 |
| Unity | `6000.2.15f1` |
| Unity-проект | `unity_ros_teleoperation`, версия `v0.2.0` |
| Платформа сборки | Android / Meta Quest |
| ROS | ROS 2 Humble или совместимая версия |
| ROS-мост | `leggedrobotics/ROS-TCP-Endpoint`, ветка `main-ros2` |
| TCP-порт | `10000` |
| Сеть | Quest и ROS-компьютер в одной локальной сети |

Не рекомендуется открывать проект в более новой версии Unity, а затем пытаться вернуть его к `6000.2.15f1`. Лучше использовать чистый clone проекта.

---

# Часть I. Сборка приложения на Windows

## 3. Установка Unity

Через Unity Hub установите:

```text
Unity 6000.2.15f1
```

При установке отметьте модули:

```text
Android Build Support
├── Android SDK & NDK Tools
└── OpenJDK
```

Проверить версию открытого редактора можно через:

```text
Help → About Unity
```

## 4. Клонирование проекта

Рекомендуется использовать стабильный тег `v0.2.0`:

```powershell
cd C:\Projects

git clone --branch v0.2.0 --depth 1 `
    https://github.com/leggedrobotics/unity_ros_teleoperation.git `
    unity_ros_teleoperation_v020
```

Добавьте проект в Unity Hub:

```text
Projects
→ Add
→ Add project from disk
→ C:\Projects\unity_ros_teleoperation_v020
```

Откройте проект именно в Unity `6000.2.15f1`.

Первый импорт пакетов может занять несколько минут. Не запускайте сборку, пока Unity продолжает импорт и компиляцию.

---

## 6. Подключение Quest 3 к Windows

На Quest должен быть включён режим разработчика.

Подключите шлем к Windows по USB-C кабелю с поддержкой передачи данных. В шлеме подтвердите:

```text
Allow USB debugging
```

Рекомендуется выбрать:

```text
Always allow from this computer
```

На Windows может потребоваться Oculus ADB Driver.

---

## 7. Проверка ADB

ADB входит в Android SDK, установленный вместе с Unity.

Обычно путь имеет вид:

```text
C:\Program Files\Unity\Hub\Editor\6000.2.15f1\
Editor\Data\PlaybackEngines\AndroidPlayer\SDK\platform-tools
```

Проверка в PowerShell:

```powershell
cd "C:\Program Files\Unity\Hub\Editor\6000.2.15f1\Editor\Data\PlaybackEngines\AndroidPlayer\SDK\platform-tools"

.\adb.exe devices
```

Ожидаемый результат:

```text
List of devices attached
XXXXXXXXXXXX    device
```

Если отображается:

```text
unauthorized
```

наденьте шлем и подтвердите USB debugging.

Если список пустой:

```powershell
.\adb.exe kill-server
.\adb.exe start-server
.\adb.exe devices
```

---

## 8. Выбор VR-сцены

В окне `Project` откройте сцену:

```text
Assets/Scenes/Main.unity
```

Затем откройте:

```text
File → Build Profiles
```

или, в другом варианте интерфейса Unity:

```text
File → Build Settings
```

В список сцен должна входить VR-сцена:

```text
[✓] Assets/Scenes/Main.unity
```

Плоскую сцену рекомендуется отключить:

```text
[ ] Assets/Scenes/2dMain.unity
```

Если `Main.unity` отсутствует в списке:

```text
Add Open Scenes
```

---

## 9. Переключение на Android / Meta Quest

Откройте:

```text
File → Build Profiles
```

Выберите:

```text
Meta Quest
```

или, если отдельного профиля Quest нет:

```text
Android
```

Нажмите:

```text
Switch Platform
```

Дождитесь завершения импорта ресурсов.

---

## 10. Настройка OpenXR

Откройте:

```text
Edit
→ Project Settings
→ XR Plug-in Management
```

Для Android должен быть включён:

```text
OpenXR
```

В настройках OpenXR должен быть активен компонент:

```text
Meta Quest Support
```

---

## 11. Разрешение сетевого доступа

ROS-мост использует обычное TCP-соединение, поэтому APK должен иметь разрешение на интернет.

Проверьте файл:

```text
Assets/Plugins/Android/AndroidManifest.xml
```

В нём должна присутствовать строка:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Затем откройте:

```text
Edit
→ Project Settings
→ XR Plug-in Management
→ OpenXR
→ Meta Quest Support
```

Отключите:

```text
Force Remove Internet
```

Эту настройку рекомендуется проверять перед каждой сборкой. Если APK уже был собран без разрешения, измените `AndroidManifest.xml`, например добавьте пустую строку, сохраните файл и пересоберите APK.

---

## 12. Настройка подписи APK

Если Unity показывает:

```text
Can not sign the application
Unable to sign the application; please provide passwords
```

откройте:

```text
Edit
→ Project Settings
→ Player
→ Android
→ Publishing Settings
```

Для локальной установки на Quest отключите:

```text
Custom Keystore
```

После этого Unity использует стандартный debug-keystore.

Если пользовательский keystore действительно нужен, необходимо заполнить:

```text
Keystore Password
Key Alias
Key Password
```

Для разработки и `Build And Run` пользовательский keystore обычно не требуется.

---

## 13. Сборка и установка через Unity

Quest должен отображаться в:

```powershell
adb devices
```

Откройте:

```text
File → Build Profiles
```

Выберите Android/Meta Quest, затем в поле:

```text
Run Device
```

выберите Quest 3.

Нажмите:

```text
Build And Run
```

Сохраните APK, например:

```text
C:\QuestBuilds\unity_ros_teleoperation.apk
```

Unity должна:

1. собрать APK;
2. установить его на Quest;
3. запустить приложение.

Установленное вручную приложение может находиться в разделе:

```text
Library → Unknown Sources
```

---

## 14. Ручная установка APK через ADB

Если Unity собрала APK, но не установила его:

```powershell
cd "C:\Program Files\Unity\Hub\Editor\6000.2.15f1\Editor\Data\PlaybackEngines\AndroidPlayer\SDK\platform-tools"

.\adb.exe install -r "C:\QuestBuilds\unity_ros_teleoperation.apk"
```

Успешная установка завершается сообщением:

```text
Success
```

Если появляется:

```text
INSTALL_FAILED_UPDATE_INCOMPATIBLE
```

старая версия приложения была подписана другим ключом. Удалите её со шлема и повторите установку.

Список пакетов можно посмотреть так:

```powershell
.\adb.exe shell pm list packages | Select-String "teleoperation"
```

Удаление:

```powershell
.\adb.exe uninstall имя.пакета
```

---

# Часть II. Установка ROS 2-моста на Ubuntu

## 15. Требования

На Ubuntu должны быть установлены:

```text
ROS 2
colcon
rosdep
git
```

Для ROS 2 Humble:

```bash
sudo apt update

sudo apt install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    git
```

Если `rosdep` ещё не инициализирован:

```bash
sudo rosdep init
rosdep update
```

Команда `sudo rosdep init` выполняется только один раз на системе.

---

## 16. Создание workspace

```bash
mkdir -p ~/quest_ros_ws/src
cd ~/quest_ros_ws/src
```

Клонируйте специальный fork endpoint и обязательно выберите ветку ROS 2:

```bash
git clone \
  --branch main-ros2 \
  https://github.com/leggedrobotics/ROS-TCP-Endpoint.git
```

Проверьте ветку:

```bash
git -C ~/quest_ros_ws/src/ROS-TCP-Endpoint branch --show-current
```

Ожидается:

```text
main-ros2
```

---

## 17. Установка зависимостей и сборка

Для ROS 2 Humble:

```bash
cd ~/quest_ros_ws

source /opt/ros/humble/setup.bash

rosdep install \
  --from-paths src \
  --ignore-src \
  --rosdistro humble \
  -r -y

colcon build --symlink-install
```

После сборки:

```bash
source /opt/ros/humble/setup.bash
source ~/quest_ros_ws/install/setup.bash
```

Для другой версии ROS замените `humble` на используемый дистрибутив.

---

## 18. Проверка выбранного пакета

Выполните:

```bash
ros2 pkg prefix ros_tcp_endpoint
```

Ожидается путь внутри workspace:

```text
/home/<user>/quest_ros_ws/install/ros_tcp_endpoint
```

Если отображается другой путь, например пакет из `/opt/ros/...`, повторно подключите окружение:

```bash
source /opt/ros/humble/setup.bash
source ~/quest_ros_ws/install/setup.bash
```

---

## 19. Определение IP ROS-компьютера

Quest должен подключаться к IP компьютера, на котором запущен `ROS-TCP-Endpoint`.

Проверка:

```bash
hostname -I
```

Более подробный просмотр интерфейсов:

```bash
ip -4 addr
```

Пример локального IP:

```text
192.168.1.42
```

Не используйте в приложении Quest:

```text
127.0.0.1
localhost
```

Осторожно с адресами Docker, VPN и виртуальных адаптеров, например:

```text
172.17.0.1
```

Нужен IP интерфейса, подключённого к той же локальной сети, что и Quest.

---

## 20. Запуск ROS-TCP-Endpoint

Подключите окружение:

```bash
source /opt/ros/humble/setup.bash
source ~/quest_ros_ws/install/setup.bash
```

Запустите сервер, указав локальный IP ROS-компьютера:

```bash
ros2 run ros_tcp_endpoint default_server_endpoint \
  --ros-args \
  -p ROS_IP:=192.168.1.42 \
  -p ROS_TCP_PORT:=10000
```

Замените `192.168.1.42` на адрес своего компьютера.

При успешном запуске должна появиться строка, аналогичная:

```text
Starting server on 192.168.1.42:10000
```

В некоторых сетевых конфигурациях можно слушать все интерфейсы:

```bash
ros2 run ros_tcp_endpoint default_server_endpoint \
  --ros-args \
  -p ROS_IP:=0.0.0.0 \
  -p ROS_TCP_PORT:=10000
```

Для обычного запуска без Docker предпочтительнее сначала использовать конкретный локальный IP.

---

# Часть III. Подключение Quest к ROS 2

## 22. Сетевая схема

Quest и Ubuntu-компьютер должны находиться в одной сети:

```text
Quest 3              Ubuntu / робот
192.168.1.x   →      192.168.1.42:10000
```

Проблемы возможны в следующих случаях:

- Quest подключён к гостевой Wi-Fi-сети;
- на роутере включена изоляция клиентов;
- Windows, Quest и Ubuntu находятся в разных VLAN;
- используется VPN;
- выбран IP Docker- или виртуального интерфейса;
- порт блокируется firewall.

---

## 23. Настройка приложения на Quest

В приложении укажите:

```text
IP:   192.168.1.42
Port: 10000
```

Здесь должен быть IP Ubuntu-компьютера с запущенным endpoint, а не IP Windows-компьютера с Unity.

После успешного подключения меню приложения должно изменить состояние или цвет на зелёный.

---

## 24. Почему приложение может показывать ROS1

В версии `v0.2.0` один APK поддерживает ROS 1 и ROS 2.

Отдельного переключателя ROS 1/ROS 2 в интерфейсе может не быть. Версия протокола определяется при подключении к совместимому `ROS-TCP-Endpoint`.

До установления соединения приложение может отображать:

```text
ROS1
```

Для работы с ROS 2 необходимо, чтобы на Ubuntu был запущен:

```text
leggedrobotics/ROS-TCP-Endpoint
```

в ветке:

```text
main-ros2
```

Если после подключения приложение продолжает показывать ROS1, проверьте:

```bash
git -C ~/quest_ros_ws/src/ROS-TCP-Endpoint branch --show-current
```

и:

```bash
ros2 pkg prefix ros_tcp_endpoint
```

Также убедитесь, что Quest действительно подключился к порту `10000`.

---

## 25. Проверка передачи данных

После подключения Quest выполните:

```bash
ros2 topic list
```

Посмотрите частоты доступных топиков:

```bash
ros2 topic hz /tf
```

Посмотрите сообщения:

```bash
ros2 topic echo /tf
```

Названия остальных топиков зависят от включённых в приложении компонентов. Проект может публиковать:

- положение шлема;
- положение контроллеров;
- положение кистей;
- TF-преобразования;
- сообщения позы;
- данные hand tracking.

Для проверки TF-графа:

```bash
ros2 run tf2_tools view_frames
```

Сначала рекомендуется проверить получение данных, не отправляя команды на реальный манипулятор.

---

# Часть IV. Типовые проблемы

## 28. `Error building Player because scripts have compile errors`

Это итоговая ошибка, а не первичная причина.

Откройте:

```text
Window → General → Console
```

Нажмите:

```text
Clear
```

и исправляйте первую красную ошибку сверху.

---

## 29. `Project has invalid dependencies`

Основные причины:

- проект открыт в неподходящей версии Unity;
- Git не установлен;
- SSH-зависимости GitHub не загружаются;
- повреждён каталог `Library`;
- проект ранее открывался в более новой версии Unity.

Рекомендуемое решение:

1. Unity `6000.2.15f1`;
2. чистый clone тега `v0.2.0`;
3. перенаправление Git SSH-ссылок на HTTPS;
4. удаление `Library`, `Temp`, `obj`, `Logs`.

---

## 30. Ошибки `SVGImporter` и `SVGSpriteData`

Не редактируйте:

```text
Library/PackageCache/com.unity.vectorgraphics
```

Используйте правильную версию Unity и пересоздайте `Library`.

---

## 31. `Unable to sign the application`

Откройте:

```text
Project Settings
→ Player
→ Android
→ Publishing Settings
```

Отключите:

```text
Custom Keystore
```

Для локальной установки Unity подпишет APK отладочным ключом.

---

## 32. Quest не отображается в `Run Device`

Проверьте:

```powershell
adb devices
```

Возможные причины:

- кабель поддерживает только зарядку;
- USB debugging не подтверждён;
- отсутствует ADB-драйвер;
- Quest показывает состояние `unauthorized`;
- ADB-сервер завис.

Перезапуск ADB:

```powershell
.\adb.exe kill-server
.\adb.exe start-server
.\adb.exe devices
```

---

## 33. APK запускается, но не подключается к ROS

Проверьте:

1. `INTERNET` присутствует в `AndroidManifest.xml`;
2. `Force Remove Internet` отключён;
3. endpoint запущен;
4. указан правильный IP Ubuntu;
5. порт `10000` слушается;
6. firewall пропускает TCP `10000`;
7. Quest и Ubuntu находятся в одной локальной сети;
8. Wi-Fi не использует изоляцию клиентов.

Команды проверки:

```bash
hostname -I
ss -ltnp | grep 10000
sudo ufw status
```

---

## 34. В приложении указано ROS1

Проверьте:

```bash
git -C ~/quest_ros_ws/src/ROS-TCP-Endpoint branch --show-current
```

Результат должен быть:

```text
main-ros2
```

Проверьте пакет:

```bash
ros2 pkg prefix ros_tcp_endpoint
```

Проверьте порт:

```bash
ss -ltnp | grep 10000
```

Надпись ROS1 до подключения сама по себе не означает, что APK собран неправильно.

---

# Часть V. Быстрый запуск после первоначальной настройки

## 35. Ubuntu

```bash
source /opt/ros/humble/setup.bash
source ~/quest_ros_ws/install/setup.bash

ROS_IP=$(hostname -I | awk '{print $1}')

ros2 run ros_tcp_endpoint default_server_endpoint \
  --ros-args \
  -p ROS_IP:=$ROS_IP \
  -p ROS_TCP_PORT:=10000
```

Если первая запись `hostname -I` принадлежит VPN или Docker, задайте IP вручную.

---

## 36. Quest

1. Запустить приложение из `Unknown Sources`.
2. Указать IP Ubuntu-компьютера.
3. Указать порт `10000`.
4. Подключиться.
5. Включить нужные компоненты публикации.
6. Проверить зелёный статус соединения.

---

## 37. Проверка на Ubuntu

```bash
ros2 topic list
ros2 topic hz /tf
```

---

# Часть VI. Рекомендации перед управлением реальным роботом

Не подключайте позу Quest непосредственно к положению манипулятора без промежуточного контроллера.

Рекомендуемая схема:

```text
Поза кисти или контроллера Quest
          ↓
калибровка начальной позы
          ↓
относительное перемещение
          ↓
масштабирование
          ↓
фильтрация
          ↓
ограничение рабочей области и скорости
          ↓
MoveIt Servo или Cartesian-контроллер
          ↓
драйвер манипулятора
```

Обязательные защитные механизмы:

- dead-man button или clutch;
- watchdog по времени последнего сообщения;
- ограничение линейной и угловой скорости;
- ограничение ускорения;
- контроль рабочей области;
- проверка сингулярностей;
- аварийная остановка;
- остановка при потере сети;
- первоначальная проверка в симуляции.

---

## 38. Используемые репозитории

Unity-приложение:

```text
https://github.com/leggedrobotics/unity_ros_teleoperation
```

ROS 2-мост:

```text
https://github.com/leggedrobotics/ROS-TCP-Endpoint
```

Для ROS 2 используется ветка:

```text
main-ros2
```
