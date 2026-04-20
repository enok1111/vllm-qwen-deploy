#!/bin/bash
source "$(dirname "$0")/config.sh"

mkdir -p "$MODELS_DIR"

echo "📥 Descargando modelo GGUF para vLLM: $MODEL_FILENAME"
echo "URL: $MODEL_URL"

# Usamos aria2c como en el original
aria2c -x 16 -s 16 "$MODEL_URL" -d "$MODELS_DIR" -o "$MODEL_FILENAME"

echo "✅ Descarga completada."
ls -lh "$MODELS_DIR/$MODEL_FILENAME"
