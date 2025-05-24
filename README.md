# k8s-local

### 1. Установка kubectl на локальный ПК:
```bash
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes && make kubectl
```

### 2. Деплой виртуалок на VirtualBox:
- для запуска нужно "положить" подготовоенный файл `ubuntu.ova` в директорию `./infra/VirtualBox/`
и запустить bash ниже:
```bash
cd ./infra/VirtualBox/
./start-vms.sh
```
- для удаления виртуалок - запустить bash ниже:
```bash
cd ./infra/VirtualBox/
./destroy-vms.sh
```
