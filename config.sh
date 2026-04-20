#!/bin/bash
# ==========================================
# CONFIGURACIÓN GLOBAL (vLLM Native Tuning)
# ==========================================

# Rutas principales
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS_DIR="$BASE_DIR/models"
VENV_DIR="$BASE_DIR/venv"
LOG_FILE="$BASE_DIR/server.log"

# Configuración del Modelo (GGUF)
MODEL_URL="https://huggingface.co/HauhauCS/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive/resolve/main/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf?download=true"
MODEL_FILENAME="Qwen35B.gguf"

# Parámetros de Inferencia (vLLM Nativo)
CONTEXT_SIZE=196608
GPU_MEMORY_UTIL=0.90
TENSOR_PARALLEL=2
KV_CACHE_DTYPE="fp8"
PORT=8080

# Monitor
IDLE_TIMEOUT=1800
# ==========================================
