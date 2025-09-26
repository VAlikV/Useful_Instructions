## Launch environment

### Creating environment folder:
```bash
python -m venv .venv
```

### Environment activation:

For Windows:

```bash
.venv\Scripts\Activate.ps1
```

For Linux:

```bash
source .venv/bin/activate
```

### If error occurs during activation:
```bash
Set-ExecutionPolicy Unrestricted -Scope Process
```

### Deactivation:
```bash
deactivate
```

### Installing requirements
```bash
python -m pip install -r requirements.txt
```

### Creating a file requirements.txt
```bash
python -m pip freeze > requirements.txt
```