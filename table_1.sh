#!/bin/bash

# Crear directorios necesarios si no existen
mkdir -p results
mkdir -p logs/GAT
mkdir -p logs/GCN
mkdir -p logs/GCNII
mkdir -p logs/GEOMGCN
mkdir -p logs/GGCN
mkdir -p logs/MLP  # Nuevo directorio para logs de MLP
mkdir -p logs/PN   # Nuevo directorio para logs de PN
mkdir -p logs/GPRGNN  # Nuevo directorio para logs de GPRGNN

# Valores de renyi a probar
RENYI_VALUES=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)

# Función para ejecutar experimentos GAT
run_GAT_experiments() {
    local dataset=$1
    local weight_decay=$2
    local hidden=$3
    local dropout=$4
    local lr=$5
    local additional_params=$6
    
    echo "Running GAT experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/GAT/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer 2 --weight_decay $weight_decay --model GAT --hidden $hidden --dropout $dropout --lr $lr --renyi $renyi $additional_params"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "GAT experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos GCN
run_GCN_experiments() {
    local dataset=$1
    local weight_decay=$2
    local hidden=$3
    local additional_params=$4
    
    echo "Running GCN experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/GCN/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer 4 --weight_decay $weight_decay --model GCN --hidden $hidden --renyi $renyi $additional_params"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "GCN experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos GCNII
run_GCNII_experiments() {
    local dataset=$1
    local layer=$2
    local weight_decay=$3
    local additional_params=$4
    
    echo "Running GCNII experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/GCNII/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer $layer --weight_decay $weight_decay --model GCNII --renyi $renyi $additional_params"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "GCNII experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos GEOMGCN
run_GEOMGCN_experiments() {
    local dataset=$1
    local weight_decay=$2
    local hidden=$3
    local dropout=$4
    local nb_heads=$5
    local lr=$6
    local additional_params=$7
    
    echo "Running GEOMGCN experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/GEOMGCN/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer 2 --weight_decay $weight_decay --model GEOMGCN --hidden $hidden --dropout $dropout --nb_heads $nb_heads --lr $lr --renyi $renyi $additional_params"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "GEOMGCN experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos GGCN
run_GGCN_experiments() {
    local dataset=$1
    local layer=$2
    local weight_decay=$3
    local hidden=$4
    local dropout=$5
    local additional_params=$6
    
    echo "Running GGCN experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/GGCN/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer $layer --weight_decay $weight_decay --model GGCN --hidden $hidden --dropout $dropout --renyi $renyi $additional_params"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "GGCN experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos MLP
run_MLP_experiments() {
    local dataset=$1
    local weight_decay=$2
    local hidden=$3
    local additional_params=$4
    
    echo "Running MLP experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/MLP/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer 2 --weight_decay $weight_decay --model MLP --hidden $hidden --renyi $renyi $additional_params"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "MLP experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos PN (PairNorm)
run_PN_experiments() {
    local dataset=$1
    
    echo "Running PN experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/PN/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer 2 --lr 0.005 --dropout 0.6 --weight_decay 5e-4 --model PN --hidden 64 --renyi $renyi"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "PN experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

# Función para ejecutar experimentos GPRGNN
run_GPRGNN_experiments() {
    local dataset=$1
    
    echo "Running GPRGNN experiments for dataset: $dataset"
    
    for renyi in "${RENYI_VALUES[@]}"; do
        echo "Running with renyi = $renyi"
        log_file="logs/GPRGNN/${dataset}_renyi${renyi}.log"
        
        # Crear el comando con los parámetros adecuados
        cmd="python -u full-supervised.py --data $dataset --layer 2 --lr 0.002 --dprate_GPRGNN 0.5 --weight_decay 5e-4 --alpha_GPRGNN 0.1 --model GPRGNN --hidden 64 --renyi $renyi"
        
        echo "Command: $cmd"
        echo "Logging to: $log_file"
        
        # Ejecutar el comando y redirigir la salida al archivo de log
        $cmd > "$log_file" 2>&1
        
        echo "GPRGNN experiment completed for $dataset with renyi = $renyi"
        echo "----------------------------------------"
    done
}

echo "Starting experiments..."

# # =========== Experimentos GAT ===========
# # Parámetros basados en el archivo paste.txt
run_GAT_experiments "cora" "5e-4" "8" "0.6" "0.005" ""
run_GAT_experiments "citeseer" "5e-4" "8" "0.6" "0.005" ""
run_GAT_experiments "chameleon" "5e-5" "8" "0.6" "0.005" ""
run_GAT_experiments "cornell" "5e-5" "8" "0.6" "0.005" ""
run_GAT_experiments "texas" "5e-5" "8" "0.6" "0.005" ""
run_GAT_experiments "wisconsin" "5e-5" "8" "0.6" "0.005" ""
run_GAT_experiments "pubmed" "5e-5" "8" "0.6" "0.005" "--use_sparse"

=========== Experimentos GCN ===========
run_GCN_experiments "cora" "5e-4" "16" ""
run_GCN_experiments "citeseer" "5e-4" "16" ""
run_GCN_experiments "pubmed" "5e-5" "16" ""
run_GCN_experiments "chameleon" "5e-5" "16" ""
run_GCN_experiments "cornell" "5e-5" "16" ""
run_GCN_experiments "texas" "5e-5" "16" ""
run_GCN_experiments "wisconsin" "5e-5" "16" ""

# # =========== Experimentos GCNII ===========
run_GCNII_experiments "cora" "64" "1e-4" "--alpha 0.2"
run_GCNII_experiments "cora" "64" "1e-4" "--alpha 0.2 --variant"
run_GCNII_experiments "citeseer" "64" "5e-6" ""
run_GCNII_experiments "citeseer" "64" "5e-6" "--variant"
run_GCNII_experiments "chameleon" "4" "5e-4" "--lamda 1.5 --alpha 0.2"
run_GCNII_experiments "chameleon" "4" "5e-4" "--lamda 1.5 --alpha 0.2 --variant"
run_GCNII_experiments "cornell" "16" "1e-3" "--lamda 1"
run_GCNII_experiments "cornell" "16" "1e-3" "--lamda 1 --variant"
run_GCNII_experiments "texas" "32" "1e-4" "--lamda 1.5"
run_GCNII_experiments "texas" "32" "1e-4" "--lamda 1.5 --variant"
run_GCNII_experiments "wisconsin" "16" "5e-4" "--lamda 1"
run_GCNII_experiments "wisconsin" "16" "5e-4" "--lamda 1 --variant"
run_GCNII_experiments "pubmed" "64" "5e-6" "--alpha 0.1"
run_GCNII_experiments "pubmed" "64" "5e-6" "--alpha 0.1 --variant"

# # =========== Experimentos GGCN ===========
run_GGCN_experiments "wisconsin" "5" "6e-4" "16" "0" ""
run_GGCN_experiments "texas" "2" "1e-3" "16" "0.4" ""
run_GGCN_experiments "cora" "32" "1e-3" "16" "0" "--decay_rate 0.9"
run_GGCN_experiments "citeseer" "10" "1e-7" "80" "0" "--decay_rate 0.02"
run_GGCN_experiments "chameleon" "5" "1e-2" "32" "0.3" "--decay_rate 0.8"
run_GGCN_experiments "cornell" "6" "1e-3" "16" "0" "--decay_rate 0.7"
run_GGCN_experiments "pubmed" "5" "1e-5" "32" "0.3" "--use_sparse --decay_rate 1.1"

# # =========== Experimentos MLP ===========
run_MLP_experiments "cornell" "1e-4" "16" ""
run_MLP_experiments "texas" "1e-4" "16" ""
run_MLP_experiments "wisconsin" "1e-4" "16" ""
run_MLP_experiments "chameleon" "1e-8" "16" ""
run_MLP_experiments "cora" "1e-4" "16" ""
run_MLP_experiments "citeseer" "1e-7" "64" ""
run_MLP_experiments "pubmed" "1e-6" "64" "--dropout 0.3"

# # =========== Experimentos PN (PairNorm) ===========
run_PN_experiments "cora"
run_PN_experiments "citeseer"
run_PN_experiments "pubmed"
run_PN_experiments "chameleon"
run_PN_experiments "cornell"
run_PN_experiments "texas"
run_PN_experiments "wisconsin"

# # =========== Experimentos GPRGNN ===========
run_GPRGNN_experiments "cora"
run_GPRGNN_experiments "citeseer"
run_GPRGNN_experiments "pubmed"
run_GPRGNN_experiments "chameleon"
run_GPRGNN_experiments "cornell"
run_GPRGNN_experiments "texas"
run_GPRGNN_experiments "wisconsin"

echo "All experiments completed!"