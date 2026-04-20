# 🚀 vLLM Qwen35 Deploy (Dual RTX 3090)

Despliegue optimizado para **Qwen3.5/3.6** con **vLLM** en 2x RTX 3090 (48GB VRAM combinada).  
Diseñado para **alta concurrencia**, máximo contexto (128k+) y compatibilidad total con OpenAI API.

## 📋 Requisitos
- Ubuntu 22.04+ o Debian 12+
- 2x NVIDIA RTX 3090 (24GB c/u)
- Drivers NVIDIA instalados (535+)

## 🛠️ Instalación y Uso

### 1. Preparar el entorno
```bash
git clone <tu-repo>
cd vllm-qwen-deploy
./1-install.sh
```

### 2. Configuración
Copia el archivo de ejemplo y añade tu token de HuggingFace si el modelo lo requiere.
```bash
cp .env.example .env
nano .env  # Añade tu HF_TOKEN
```
Puedes ajustar parámetros como `MAX_MODEL_LEN` o `MAX_NUM_SEQS` en `config.sh`.

### 3. Descarga y Ejecución
```bash
./2-download.sh
./3-run.sh
```

### 4. Monitorización
```bash
./monitor.sh &
```

## ⚙️ Arquitectura
- **vLLM**: Backend de inferencia de alto rendimiento.
- **Continuous Batching**: Maneja múltiples peticiones simultáneas de forma eficiente.
- **KV Cache FP8**: Optimizado para GPUs Ampere (3090), reduciendo el uso de memoria a la mitad sin pérdida notable de precisión.
- **Prefix Caching**: Acelera peticiones con prompts repetitivos (agentes, RAG).

## 📊 Endpoints
- **API Base**: `http://localhost:8000/v1`
- **Models**: `GET /v1/models`
- **Chat**: `POST /v1/chat/completions`
