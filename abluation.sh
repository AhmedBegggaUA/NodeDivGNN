#!/bin/bash

# Crear directorios necesarios si no existen
mkdir -p results
mkdir -p logs/GAT
mkdir -p logs/GCN

# Valores de renyi a probar
RENYI_VALUES=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)

# Datasets a utilizar
DATASETS=("cora" "citeseer")

# Número de capas a probar
LAYERS_MIN=1
LAYERS_MAX=10

# Función para ejecutar experimentos GCN
run_GCN_experiments() {
    local dataset=$1
    local weight_decay=$2
    local hidden=$3
    local additional_params=$4
    
    echo "Running GCN experiments for dataset: $dataset"
    
    for layer in $(seq $LAYERS_MIN $LAYERS_MAX); do
        for renyi in "${RENYI_VALUES[@]}"; do
            echo "Running GCN with dataset=$dataset, layer=$layer, renyi=$renyi"
            log_file="logs/GCN/${dataset}_layer${layer}_renyi${renyi}.log"
            
            # Crear el comando con los parámetros adecuados
            cmd="python -u full-supervised.py --data $dataset --layer $layer --weight_decay $weight_decay --model GCN --hidden $hidden --renyi $renyi $additional_params"
            
            echo "Command: $cmd"
            echo "Logging to: $log_file"
            
            # Ejecutar el comando y redirigir la salida al archivo de log
            $cmd > "$log_file" 2>&1
            
            echo "GCN experiment completed for $dataset with layer=$layer, renyi=$renyi"
            echo "----------------------------------------"
        done
    done
}

# Función para ejecutar experimentos GAT
run_GAT_experiments() {
    local dataset=$1
    local weight_decay=$2
    local hidden=$3
    local dropout=$4
    local lr=$5
    local additional_params=$6
    
    echo "Running GAT experiments for dataset: $dataset"
    
    for layer in $(seq $LAYERS_MIN $LAYERS_MAX); do
        for renyi in "${RENYI_VALUES[@]}"; do
            echo "Running GAT with dataset=$dataset, layer=$layer, renyi=$renyi"
            log_file="logs/GAT/${dataset}_layer${layer}_renyi${renyi}.log"
            
            # Crear el comando con los parámetros adecuados
            cmd="python -u full-supervised.py --data $dataset --layer $layer --weight_decay $weight_decay --model GAT --hidden $hidden --dropout $dropout --lr $lr --renyi $renyi $additional_params"
            
            echo "Command: $cmd"
            echo "Logging to: $log_file"
            
            # Ejecutar el comando y redirigir la salida al archivo de log
            $cmd > "$log_file" 2>&1
            
            echo "GAT experiment completed for $dataset with layer=$layer, renyi=$renyi"
            echo "----------------------------------------"
        done
    done
}

echo "Starting experiments..."

# =========== Experimentos GCN ===========
# Parámetros basados en el archivo original
run_GCN_experiments "cora" "5e-4" "16" ""
run_GCN_experiments "citeseer" "5e-4" "16" ""

# =========== Experimentos GAT ===========
# Parámetros basados en el archivo original
run_GAT_experiments "cora" "5e-4" "8" "0.6" "0.005" ""
run_GAT_experiments "citeseer" "5e-4" "8" "0.6" "0.005" ""

echo "All experiments completed!"