#!/bin/bash
# ==========================================
# CONFIGURACIÓN GLOBAL (vLLM Pro Tuning)
# ==========================================

# Rutas principales (Idénticas a llm-server-deploy)
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODELS_DIR="$BASE_DIR/models"
LOG_FILE="$BASE_DIR/server.log"

# Configuración del Modelo (Mismo GGUF que llama.cpp)
MODEL_URL="https://huggingface.co/HauhauCS/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive/resolve/main/Qwen3.6-35B-A3B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf?download=true"
MODEL_FILENAME="Qwen35B.gguf"

# Parámetros de Inferencia (Optimizados para vLLM + Dual 3090)
CONTEXT_SIZE=131072    # 131k de contexto
GPU_MEMORY_UTIL=0.90   # vLLM gestiona mejor la VRAM
TENSOR_PARALLEL=2      # Dual GPU
KV_CACHE_DTYPE="fp8"   # Forzar FP8 para maximizar contexto
PORT=8080              # Mismo puerto que el original

# Monitor de Auto-Apagado
IDLE_TIMEOUT=1800      # 30 minutos
CONTAINER_NAME="vllm-server-pro"
API_KEY="sk-vllm-pro-$(date +%s)"
# ==========================================
