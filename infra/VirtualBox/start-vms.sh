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
