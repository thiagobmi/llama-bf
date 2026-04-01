# Setup de Benchmark 

Passo a passo para preparar o ambiente na máquina capivara e executar os testes locais.

### 1. Permissões
Garanta que todos os scripts do diretório são executáveis:
`chmod +x *.sh`

### 2. Instalação e Compilação
Baixa o repositório oficial do llama.cpp e compila os binários necessários usando os núcleos disponíveis.
`./install_lammacpp.sh`

### 3. Download dos Modelos
Baixa alguns modelos do HuggingFace usando o wget
`./download_models.sh`

### 4. Execução do Benchmark (Local)
Inicia a bateria de testes usando apenas o processamento local, sem offload para a rede.
`./bench-local.sh`

---
O progresso do teste aparecerá no terminal. Ao final da execução, as tabelas com as métricas de tokens por segundo (t/s) serão salvas automaticamente na pasta `resultados/` em formato `.md`.
