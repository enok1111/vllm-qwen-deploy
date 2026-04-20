#!/bin/bash
source "$(dirname "$0")/config.sh"

echo "🛠️ [1/2] Instalando dependencias del sistema y Docker..."
sudo apt-get update
sudo apt-get install -y build-essential cmake git libcurl4-openssl-dev libssl-dev aria2 docker.io docker-compose-plugin curl

# Configurar NVIDIA Container Toolkit
echo "📦 [2/2] Configurando NVIDIA Container Toolkit..."
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

echo "✅ Instalación completada. Prueba con: docker run --rm --gpus all nvidia/cuda:12.4.1-base-ubuntu22.04 nvidia-smi"
