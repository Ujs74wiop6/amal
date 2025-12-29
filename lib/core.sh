#!/usr/bin/env bash

# =============================
# CORE - CONFIGURAÇÕES GLOBAIS
# =============================

set -euo pipefail

# =============================
# OUTPUT PADRONIZADO
# =============================

info() {
    echo -e "→ $*"
}

success() {
    echo -e "✓ $*"
}

warn() {
    echo -e "⚠ $*"
}

error() {
    echo -e "✗ $*"
    exit 1
}

# =============================
# VALIDAÇÕES
# =============================

require_command() {
    local cmd="$1"

    if ! command -v "$cmd" &> /dev/null; then
        error "Comando obrigatório não encontrado: $cmd"
    fi
}

require_sudo() {
    require_command sudo
}

# =============================
# UTILITÁRIOS
# =============================

install_if_missing() {
    local cmd="$1"
    local install_cmd="$2"

    if ! command -v "$cmd" &> /dev/null; then
        info "Instalando $cmd..."
        eval "$install_cmd"
        success "$cmd instalado."
    else
        success "$cmd já instalado."
    fi
}