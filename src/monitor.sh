#!/bin/bash
source "$(dirname "$0")/../config.sh"

CHECK_INTERVAL=60
LAST_ACTIVE_TIME=$(date +%s)

echo "🔄 Monitor vLLM activado. Timeout: $IDLE_TIMEOUT segundos."

while true; do
    sleep "$CHECK_INTERVAL"
    CURRENT_TIME=$(date +%s)
    
    # vLLM logea "Received request" o "Avg prompt throughput" cuando hay actividad
    if tail -n 50 "$LOG_FILE" 2>/dev/null | grep -Ei "Received request|Generation|throughput" > /dev/null; then
        LAST_ACTIVE_TIME=$CURRENT_TIME
    fi
    
    DIFF=$((CURRENT_TIME - LAST_ACTIVE_TIME))
    
    if [ "$DIFF" -gt "$IDLE_TIMEOUT" ]; then
        echo "$(date) → Inactividad detectada. Apagando contenedor..." >> "$LOG_FILE"
        docker compose down
        exit 0
    fi
done
