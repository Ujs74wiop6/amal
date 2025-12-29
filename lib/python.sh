#!/usr/bin/env bash

# =============================
# MAPEAMENTO DE PACOTES
# =============================

get_python_packages() {
    case "$DISTRO" in
        ubuntu|debian)
            echo "python3 python3-pip python3-venv"
            ;;
        fedora)
            echo "python3 python3-pip"
            ;;
        arch)
            echo "python python-pip"
            ;;
        *)
            error "Distribuição não suportada para Python."
            ;;
    esac
}

# =============================
# INSTALAÇÃO
# =============================

install_python() {
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