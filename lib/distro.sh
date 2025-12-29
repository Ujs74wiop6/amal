#!/usr/bin/env bash

# =============================
# DETECÇÃO DE DISTRIBUIÇÃO
# =============================

if [[ ! -f /etc/os-release ]]; then
    error "Arquivo /etc/os-release não encontrado. Distro não suportada."
fi

# shellcheck disable=SC1091
source /etc/os-release

DISTRO_ID="$ID"
DISTRO_NAME="$NAME"

# =============================
# NORMALIZAÇÃO POR FAMÍLIA
# =============================

case "$ID" in
    ubuntu|debian)
        DISTRO_FAMILY="debian"
        PKG_MANAGER="apt"
        UPDATE_CMD="sudo apt update"
        INSTALL_CMD="sudo apt install -y"
        ;;
    fedora)
        DISTRO_FAMILY="redhat"
        PKG_MANAGER="dnf"
        UPDATE_CMD="sudo dnf makecache"
        INSTALL_CMD="sudo dnf install -y"
        ;;
    arch)
        DISTRO_FAMILY="arch"
        PKG_MANAGER="pacman"
        UPDATE_CMD="sudo pacman -Sy"
        INSTALL_CMD="sudo pacman -S --noconfirm"
        ;;
    *)
        error "Distribuição não suportada: $ID"
        ;;
esac

success "Distribuição detectada: $DISTRO_NAME ($DISTRO_FAMILY)"