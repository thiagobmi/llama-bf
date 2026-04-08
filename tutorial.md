# Setup de Benchmark - TCC

Passo a passo para preparar o ambiente e executar os testes locais e distribuídos (RPC) entre a BlueField-2 e o Servidor Host.

## Parte 1: Máquina Local (DPU / BF2)

### 1. Permissões
Garanta que todos os scripts do diretório são executáveis:
`chmod +x *.sh`

### 2. Instalação e Compilação
Baixa o repositório oficial do llama.cpp e compila os binários necessários usando os núcleos ARM da placa.
`./install_lammacpp.sh`

### 3. Download dos Modelos
Baixa os modelos GGUF do HuggingFace usando o wget. 
`./download_models.sh`

### 4. Execução do Benchmark (Local)
Inicia a bateria de testes usando apenas o processamento da DPU, sem offload para a rede.
`./bench-local.sh`

---

## Parte 2: Aceleração via Rede (Host x86 + RPC)

Para rodar os testes distribuídos, o servidor Host precisa estar rodando o motor de inferência para receber as matrizes matemáticas via barramento PCIe.

### 5. Compilação no Host
Abra um terminal no **Servidor Host** (a máquina principal), baixe e compile o motor com a flag de rede ativada:
```bash
git clone --depth 1 [https://github.com/ggerganov/llama.cpp.git](https://github.com/ggerganov/llama.cpp.git)
cd llama.cpp
mkdir build && cd build
cmake .. -DLLAMA_RPC=ON
make -j$(nproc) rpc-server
```

### 6. Iniciar o Servidor RPC
Ainda no terminal do **Host**, suba o servidor escutando na porta 50052:
```bash
./bin/rpc-server -p 50052
```

### 7. Execução do Benchmark (Distribuído)
Com o servidor rodando no Host, ALTERE O IP DO HOST NO SCRIPT `bench-rpc.sh`.
Depois, volte para o terminal da **DPU (BF2)** e rode o script de teste RPC:
`./bench-rpc.sh`

---

**📊 Resultados:** O progresso do teste aparecerá no terminal. Ao final da execução, as tabelas com as métricas de tokens por segundo (t/s) de ambos os testes serão salvas automaticamente na pasta `resultados/` em formato `.md`.
