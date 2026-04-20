#!/bin/bash
source "$(dirname "$0")/config.sh"

mkdir -p "$MODELS_DIR"

echo "📥 Descargando modelo: $MODEL_FILENAME"
echo "URL: $MODEL_URL"

# Solo aria2c para máxima simplicidad, como en el repo de llama
aria2c -x 16 -s 16 "$MODEL_URL" -d "$MODELS_DIR" -o "$MODEL_FILENAME"

echo "✅ Descarga completada."
ls -lh "$MODELS_DIR/$MODEL_FILENAME"
