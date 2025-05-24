# k8s-local

### 1. Установка kubectl на локальный ПК:
```bash
git clone https://github.com/kubernetes/kubernetes.git
cd kubernetes && make kubectl
```

### 2. Деплой виртуалок на VirtualBox:
```
#!/bin/bash

# 📦 Путь до OVA-образа
OVA_FILE="./ubuntu.ova"

# 🖥️ Названия виртуальных машин
VM1_NAME="ubuntu-vm-1"
VM2_NAME="ubuntu-vm-2"

# 🔌 Проброс портов (хост → гостевой SSH 22)
VM1_PORT=2200
VM2_PORT=2201
#!/bin/bash

source ./config.sh

echo "🛑 Остановка и удаление виртуалок..."

for VM in "$VM1_NAME" "$VM2_NAME"; do
    if VBoxManage list vms | grep "\"$VM\"" >/dev/null; then
        echo "📍 Обработка $VM"

        if VBoxManage list runningvms | grep "\"$VM\"" >/dev/null; then
            echo "⚙️ Остановка $VM..."
            VBoxManage controlvm "$VM" poweroff
        fi

        echo "🗑️ Удаление $VM..."
        VBoxManage unregistervm "$VM" --delete
    else
        echo "ℹ️ ВМ $VM не найдена, пропускаем."
    fi
done

echo "✅ Завершено."
#!/bin/bash

source ./config.sh

echo "📦 Импорт первой виртуалки: $VM1_NAME"
VBoxManage import "$OVA_FILE" --vsys 0 --vmname "$VM1_NAME"

echo "📦 Импорт второй виртуалки: $VM2_NAME"
VBoxManage import "$OVA_FILE" --vsys 0 --vmname "$VM2_NAME"

echo "⚙️ Настройка ресурсов и сети..."

# VM1
VBoxManage modifyvm "$VM1_NAME" --cpus 1 --memory 2048
VBoxManage modifyvm "$VM1_NAME" --nic1 nat
VBoxManage modifyvm "$VM1_NAME" --natpf1 "guestssh,tcp,,${VM1_PORT},,22"

# VM2
VBoxManage modifyvm "$VM2_NAME" --cpus 1 --memory 2048
VBoxManage modifyvm "$VM2_NAME" --nic1 nat
VBoxManage modifyvm "$VM2_NAME" --natpf1 "guestssh,tcp,,${VM2_PORT},,22"

echo "🚀 Запуск виртуалок..."
VBoxManage startvm "$VM1_NAME" --type headless
VBoxManage startvm "$VM2_NAME" --type headless

echo "✅ Виртуальные машины запущены:"
echo "   🖥️ $VM1_NAME → порт $VM1_PORT"
echo "   🖥️ $VM2_NAME → порт $VM2_PORT"

echo ""
echo "🔑 SSH доступ:"
echo "   👉 VM1: ssh ubuntu@localhost -p $VM1_PORT"
echo "   👉 VM2: ssh ubuntu@localhost -p $VM2_PORT"

```
