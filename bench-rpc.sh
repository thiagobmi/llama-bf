#!/bin/bash


# Configuração RPC Fixa
RPC_SERVER="<IP_DO_HOST>:50052"  # IP e porta do Host


# Caminhos
LLAMA_BENCH="./llama.cpp/build/bin/llama-bench"
MODELS_DIR="./modelos"
RESULTS_DIR="./resultados"

# Parâmetros de benchmark gerais
PROMPT_TOKENS=256      # tamanho sintético do prompt (prefill)
GEN_TOKENS=64          # tokens gerados (decode)
REPETITIONS=1          # número de repetições

# Configuração de Threads (Para a DPU gerenciar a rede)
LIMIT_THREADS=false    # Mude para 'true' para forçar um limite de núcleos
THREADS=8              # Número de núcleos


# Cria o diretório de resultados se não existir
mkdir -p "$RESULTS_DIR"

# Prepara o nome do arquivo de log com timestamp
DATA_HORA=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="$RESULTS_DIR/benchmark_RPC_${DATA_HORA}.md"

# Prepara a flag de Threads
THREAD_FLAG=""
if [ "$LIMIT_THREADS" = true ]; then
    THREAD_FLAG="-t $THREADS"
    INFO_THREADS="$THREADS"
else
    INFO_THREADS="Não especificado (Padrão do llama.cpp)"
fi

# Cabeçalho do log
{
    echo "========================================================="
    echo "Iniciando Benchmark..."
    echo "Modo: DISTRIBUÍDO (RPC ativado -> $RPC_SERVER)"
    echo "Offload: 100% das camadas para o Host (-ngl 99)"
    echo "Prompt tokens: $PROMPT_TOKENS | Gen tokens: $GEN_TOKENS | Repetições: $REPETITIONS"
    echo "Threads Locais: $INFO_THREADS"
    echo "Warmup: desativado"
    echo "========================================================="
} | tee -a "$LOG_FILE"

echo "Os resultados serão salvos em: $LOG_FILE"

# Loop pelos modelos
for model in "$MODELS_DIR"/*.gguf; do
    if [ ! -e "$model" ]; then
        echo "Nenhum modelo .gguf encontrado em $MODELS_DIR." | tee -a "$LOG_FILE"
        exit 1
    fi

    nome_modelo=$(basename "$model")
    echo -e "\n▶ Testando: $nome_modelo" | tee -a "$LOG_FILE"

    # Executa o benchmark DISTRIBUÍDO
    $LLAMA_BENCH \
        -m "$model" \
        -p $PROMPT_TOKENS \
        -n $GEN_TOKENS \
        -r $REPETITIONS \
        -ngl 99 \
        --rpc $RPC_SERVER \
        $THREAD_FLAG \
        --no-warmup | tee -a "$LOG_FILE"

    echo "---------------------------------------------------------" | tee -a "$LOG_FILE"
done

echo -e "\nBenchmark DISTRIBUÍDO finalizado! Resultados disponíveis em: $LOG_FILE"
