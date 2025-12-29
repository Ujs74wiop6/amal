#!/usr/bin/env bash

# =============================
# CONTROLE DE ATUALIZAÇÃO
# =============================

SYSTEM_UPDATED=false

update_system() {
    if [[ "$SYSTEM_UPDATED" == true ]]; then
        info "Sistema já atualizado. Pulando."
        return
    fi

    info "Atualizando cache do sistema..."
    $UPDATE_CMD
    SYSTEM_UPDATED=true
}

# =============================
# VERIFICAÇÃO DE PACOTES
# =============================

is_installed() {
    local package="$1"

    case "$PKG_MANAGER" in
        apt)
            dpkg -s "$package" &>/dev/null
            ;;
        dnf)
            rpm -q "$package" &>/dev/null
            ;;
        pacman)
            pacman -Qi "$package" &>/dev/null
            ;;
        *)
            error "Gerenciador de pacotes desconhecido."
            ;;
    esac
}

# =============================
# INSTALAÇÃO GENÉRICA
# =============================

install_package() {
    local package="$1"

    if is_installed "$package"; then
        info "Pacote já instalado: $package"
    else
        info "Instalando pacote: $package"
        $INSTALL_CMD "$package"
    fi
}

# =============================
# PACOTES ESSENCIAIS
# =============================

ESSENTIAL_PACKAGES=(
    neofetch
    tmux
    htop
    curl
    git
)

install_essential_packages() {
    update_system

    info "Instalando pacotes essenciais..."

    for pkg in "${ESSENTIAL_PACKAGES[@]}"; do
        install_package "$pkg"
    done

    success "Pacotes essenciais verificados."
}