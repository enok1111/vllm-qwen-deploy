#!/bin/bash
source "$(dirname "$0")/config.sh"

echo "🧹 Limpiando procesos antiguos..."
pkill -f "vllm.entrypoints.openai.api_server" || true
pkill -f "vllm serve" || true
pkill -f monitor.sh || true
sleep 2

echo "🚀 Arrancando Servidor vLLM Nativo..."

# Usar el ejecutable de python del venv directamente para asegurar el entorno
VENV_PYTHON="$VENV_DIR/bin/python"

if [ ! -f "$VENV_PYTHON" ]; then
    echo "❌ Error: No se encontró el entorno virtual en $VENV_DIR"
    echo "Por favor, ejecuta ./1-install.sh primero."
    exit 1
fi

# Iniciar vLLM en background (OpenAI API Server)
nohup "$VENV_PYTHON" -m vllm.entrypoints.openai.api_server \
    --model "$MODELS_DIR/$MODEL_FILENAME" \
    --tensor-parallel-size "$TENSOR_PARALLEL" \
    --max-model-len "$CONTEXT_SIZE" \
    --gpu-memory-utilization "$GPU_MEMORY_UTIL" \
    --kv-cache-dtype "$KV_CACHE_DTYPE" \
    --enable-prefix-caching \
    --served-model-name qwen35-pro \
    --port "$PORT" \
    > "$LOG_FILE" 2>&1 &

echo $! > "$BASE_DIR/server.pid"

# Iniciar monitor
nohup bash "$BASE_DIR/src/monitor.sh" > "$BASE_DIR/logs/monitor.log" 2>&1 &

echo "========================================="
echo "✨ Servidor vLLM Nativo en línea (Puerto: $PORT)"
echo "📊 Modelo GGUF: $MODEL_FILENAME"
echo "📝 Logs: tail -f $LOG_FILE"
echo "🛑 Para detener: pkill -f vllm && pkill -f monitor.sh"
echo "========================================="
