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
