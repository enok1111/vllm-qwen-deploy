#!/bin/bash
source "$(dirname "$0")/config.sh"

echo "🛠️ [1/3] Instalando dependencias del sistema..."
apt-get update
apt-get install -y python3-pip python3-venv python3-full aria2 build-essential

echo "🐍 [2/3] Creando entorno virtual..."
# Borrar si existe para evitar conflictos de instalaciones fallidas
rm -rf "$VENV_DIR"
python3 -m venv "$VENV_DIR"

# Usar el pip del venv directamente para evitar PEP 668
VENV_PIP="$VENV_DIR/bin/pip"

echo "🚀 [3/3] Instalando vLLM en el entorno virtual (esto puede tardar)..."
"$VENV_PIP" install --upgrade pip
"$VENV_PIP" install vllm

echo "✅ Instalación nativa completada."
echo "Para verificar: $VENV_DIR/bin/python -c 'import vllm; print(vllm.__version__)'"
