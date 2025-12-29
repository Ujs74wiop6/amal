#!/usr/bin/env bash

# =============================
# DEFINIÇÃO DO PACOTE DOCKER
# =============================

get_docker_package() {
    case "$DISTRO" in
        ubuntu|debian)
            echo "docker.io"
            ;;
        fedora|arch)
            echo "docker"
            ;;
        *)
            error "Distribuição não suportada para Docker."
            ;;
    esac
}

# =============================
# INSTALAÇÃO DO DOCKER
# =============================

install_docker() {
    local docker_pkg
    docker_pkg="$(get_docker_package)"

    info "Verificando Docker..."

    install_package "$docker_pkg"

    success "Docker verificado."
}

# =============================
# SERVIÇO DOCKER
# =============================

enable_docker_service() {
    if ! systemctl is-enabled docker &>/dev/null; then
        info "Habilitando serviço Docker..."
        sudo systemctl enable docker
    else
        info "Serviço Docker já habilitado."
    fi
}

start_docker_service() {
    if ! systemctl is-active docker &>/dev/null; then
        info "Iniciando serviço Docker..."
        sudo systemctl start docker
    else
        info "Serviço Docker já está ativo."
    fi
}

# =============================
# GRUPO DOCKER
# =============================

configure_docker_group() {
    if groups "$USER" | grep -qw docker; then
        info "Usuário já pertence ao grupo docker."
    else
        info "Adicionando usuário ao grupo docker..."
        sudo usermod -aG docker "$USER"
        DOCKER_GROUP_ADDED=true
    fi
}

# =============================
# ORQUESTRAÇÃO
# =============================

setup_docker() {
    install_docker
    enable_docker_service
    start_docker_service
    configure_docker_group

    success "Docker configurado."
}