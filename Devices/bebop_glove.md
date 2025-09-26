## Подключение перчаток BeBop data glove

SDK для подклячения перчаток недоступно - сайт сдох

Можно подключить только на windows через python библиотеку

```bash
pip install dataglove
```

Подключать либо через свисток, либо через USB

### Пример

```python
from dataglove import *

leftHand = Forte_CreateDataGloveIO(1, "") # 0 for right-handed glove
try:
	while True:
		try:
			sensors = Forte_GetSensors(leftHand)
			imu = Forte_GetIMU(leftHand)
			print(sensors)
			print(imu)
		except(GloveDisconnectedException):
			print("Glove is Disconnected")
			pass
except(KeyboardInterrupt):
	Forte_DestroyDataGloveIO(leftHand)
	exit()
```