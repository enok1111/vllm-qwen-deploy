#!/bin/bash
source "$(dirname "$0")/config.sh"

echo "🧹 Limpiando procesos y contenedores antiguos..."
docker compose down 2>/dev/null || true
pkill -f monitor.sh || true
sleep 2

echo "🚀 Arrancando Servidor vLLM Pro (GGUF Mode)..."
# Asegurar que el log existe para que el monitor no falle al inicio
touch "$LOG_FILE"

# Iniciar vLLM via Docker
docker compose up -d

# Iniciar monitor en background (igual que el original)
nohup bash "$BASE_DIR/src/monitor.sh" > "$BASE_DIR/logs/monitor.log" 2>&1 &

echo "========================================="
echo "✨ Servidor vLLM en línea (Puerto: $PORT)"
echo "📊 Modelo GGUF: $MODEL_FILENAME"
echo "📝 Logs: tail -f $LOG_FILE"
echo "🛑 Para detener: docker compose down && pkill -f monitor.sh"
echo "========================================="
