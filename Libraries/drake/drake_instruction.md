## Инстручкия по установке библиотеки drake

1. Скачать архив drake-1.42.0-jammy.tar.gz

2. Распаковать его

```bash
tar -xzf drake-1.42.0-jammy.tar.gz -C ~/drake

```

3. В ~/.bashrc прописать

```bash
export DRAKE_INSTALL_DIR=$HOME/drake/drake
export PATH=$DRAKE_INSTALL_DIR/bin:$PATH
export PYTHONPATH=$DRAKE_INSTALL_DIR/lib/python3.10/site-packages:$PYTHONPATH
export CMAKE_PREFIX_PATH=$DRAKE_INSTALL_DIR:$CMAKE_PREFIX_PATH
```

4. Выполнить `source ~/.bashrc` или перезагрузить консоль

***Готово***