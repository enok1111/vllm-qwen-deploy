#!/bin/bash
source "$(dirname "$0")/../config.sh"

CHECK_INTERVAL=60
LAST_ACTIVE_TIME=$(date +%s)

echo "🔄 Monitor vLLM Nativo activado. Timeout: $IDLE_TIMEOUT segundos."

while true; do
    sleep "$CHECK_INTERVAL"
    CURRENT_TIME=$(date +%s)
    
    # Verificar si el proceso vLLM sigue vivo
    if ! pgrep -f "vllm" > /dev/null; then
        echo "[$(date)] ⚠️ Proceso vLLM no encontrado. Reiniciando..." >> "$LOG_FILE"
        bash "$BASE_DIR/3-run.sh"
        exit 0
    fi

    # Buscar actividad en los logs
    if tail -n 50 "$LOG_FILE" 2>/dev/null | grep -Ei "Received request|Generation|throughput" > /dev/null; then
        LAST_ACTIVE_TIME=$CURRENT_TIME
    fi
    
    DIFF=$((CURRENT_TIME - LAST_ACTIVE_TIME))
    
    if [ "$DIFF" -gt "$IDLE_TIMEOUT" ]; then
        echo "$(date) → Inactividad detectada. Apagando servidor..." >> "$LOG_FILE"
        pkill -f "vllm"
        exit 0
    fi
done
