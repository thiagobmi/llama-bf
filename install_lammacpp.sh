#!/bin/bash

# Define o nome do diretório
DIR_NOME="llama.cpp"

echo "========================================================="
echo "Baixando e compilando o llama.cpp com suporte a RPC..."
echo "========================================================="

# 1. Clona o repositório (usando --depth 1 para baixar mais rápido, sem o histórico inteiro)
if [ ! -d "$DIR_NOME" ]; then
    git clone --depth 1 https://github.com/ggerganov/llama.cpp.git
else
    echo "O diretório $DIR_NOME já existe. Puxando atualizações..."
    cd $DIR_NOME && git pull && cd ..
fi

# 2. Entra na pasta e prepara o build
cd $DIR_NOME
mkdir -p build
cd build

# 3. Configura o CMake habilitando o RPC
echo "Configurando o CMake..."
cmake .. -DLLAMA_RPC=ON

# 4. Compila inteligentemente (usa todos os núcleos - 1, para não travar a DPU)
CORES=$(nproc)
if [ "$CORES" -gt 1 ]; then
    MAKE_CORES=$((CORES - 1))
else
    MAKE_CORES=1
fi

echo "Iniciando a compilação com $MAKE_CORES threads..."
make -j$MAKE_CORES

echo "========================================================="
echo "✅ Compilação finalizada com sucesso!"
echo "Os binários (llama-cli, llama-bench, rpc-server) estão em: ./llama.cpp/build/bin/"
echo "========================================================="
