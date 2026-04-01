#!/bin/bash

# Define o diretório de destino
DIR="./modelos"

# 1. Cria a pasta (se não existir) sem entrar nela
mkdir -p "$DIR"

# 2. Baixando a família Qwen 2.5 (Excelentes e leves)
# Qwen 2.5 0.5B (Q4_K_M) - ~398 MB
wget -P "$DIR" https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf

# Qwen 2.5 1.5B (Q4_K_M) - ~1.04 GB
wget -P "$DIR" https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct-GGUF/resolve/main/qwen2.5-1.5b-instruct-q4_k_m.gguf

# Qwen 2.5 7B (Q4_K_M) - ~4.33 GB
wget -P "$DIR" https://huggingface.co/Qwen/Qwen2.5-7B-Instruct-GGUF/resolve/main/qwen2.5-7b-instruct-q4_k_m.gguf

# 3. Baixando a família Llama 3 / 3.2
# Llama 3.2 1B (Q8_0) - ~1.32 GB
wget -P "$DIR" https://huggingface.co/bartowski/Llama-3.2-1B-Instruct-GGUF/resolve/main/Llama-3.2-1B-Instruct-Q8_0.gguf

# Llama 3.2 3B (Q4_K_M) - ~2.01 GB
wget -P "$DIR" https://huggingface.co/bartowski/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct-Q4_K_M.gguf

# Llama 3 8B (Q4_0) - ~4.66 GB
wget -P "$DIR" https://huggingface.co/bartowski/Meta-Llama-3-8B-Instruct-GGUF/resolve/main/Meta-Llama-3-8B-Instruct-Q4_0.gguf

# 4. Baixando a família Gemma
# Gemma 2B (Q4_0) - ~1.50 GB
wget -P "$DIR" https://huggingface.co/bartowski/gemma-1.1-2b-it-GGUF/resolve/main/gemma-1.1-2b-it-Q4_0.gguf

# Gemma 7B (Q4_0) - ~4.90 GB
wget -P "$DIR" https://huggingface.co/bartowski/gemma-1.1-7b-it-GGUF/resolve/main/gemma-1.1-7b-it-Q4_0.gguf

# Gemma 2 9B (Q4_0) - ~5.40 GB
wget -P "$DIR" https://huggingface.co/bartowski/gemma-2-9b-it-GGUF/resolve/main/gemma-2-9b-it-Q4_0.gguf
