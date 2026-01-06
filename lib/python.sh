#!/usr/bin/env bash

# =============================
# VALIDAÇÃO DE CONTEXTO
# =============================

require_python_context() {
    : "${DISTRO_FAMILY:?}"
}

# =============================
# MAPEAMENTO DE PACOTES
# =============================

get_python_packages() {
    case "$DISTRO_FAMILY" in
        debian)
            echo "python3 python3-pip python3-venv"
            ;;
        redhat)
            echo "python3 python3-pip"
            ;;
        arch)
            echo "python python-pip"
            ;;
        *)
            error "Distribuição não suportada para Python."
            exit 1
            ;;
    esac
}

# =============================
# INSTALAÇÃO
# =============================

install_python() {
    require_python_context

    info "Verificando ambiente Python..."

    local packages
    packages="$(get_python_packages)"

    for pkg in $packages; do
        install_package "$pkg"
    done

    success "Python verificado."
}

# =============================
# VERIFICAÇÃO
# =============================

verify_python() {
    info "Versões instaladas:"

    if command -v python3 &>/dev/null; then
        python3 --version
    elif command -v python &>/dev/null; then
        python --version
    else
        warn "Python não encontrado no PATH."
    fi

    if command -v pip3 &>/dev/null; then
        pip3 --version
    elif command -v pip &>/dev/null; then
        pip --version
    else
        warn "pip não encontrado no PATH."
    fi
}

# =============================
# ORQUESTRAÇÃO
# =============================

setup_python() {
    install_python
    verify_python
}