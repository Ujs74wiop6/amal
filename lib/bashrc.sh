#!/usr/bin/env bash

BASHRC_FILE="$HOME/.bashrc"
START_MARK="# >>> SETUP_LINUX_AUTOMATICO >>>"
END_MARK="# <<< SETUP_LINUX_AUTOMATICO <<<"

# =============================
# REMOÇÃO DO BLOCO ANTIGO
# =============================

remove_old_block() {
    if [[ -f "$BASHRC_FILE" ]]; then
        sed -i "/$START_MARK/,/$END_MARK/d" "$BASHRC_FILE"
        info "Bloco antigo do .bashrc removido (se existia)."
    fi
}

# =============================
# BLOCO NOVO
# =============================

append_new_block() {
    info "Aplicando configurações no .bashrc..."

    cat <<EOF >> "$BASHRC_FILE"

$START_MARK

# =============================
# LISTAGEM
# =============================
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# =============================
# UTILITÁRIOS
# =============================
alias cls='clear'
alias neo='neofetch'
alias internet='ping -c 4 8.8.8.8'

# =============================
# SISTEMA (USE COM CAUTELA)
# =============================
alias sN='sudo shutdown now'
alias rB='sudo reboot'

# =============================
# PYTHON
# =============================
alias py='python3'
alias pipup='pip3 install --upgrade pip'
alias venv='python3 -m venv venv'

# =============================
# UPDATE MULTIDISTRO
# =============================
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
fi

if [[ "\$ID" == "ubuntu" || "\$ID" == "debian" ]]; then
    alias update='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'
elif [[ "\$ID" == "fedora" ]]; then
    alias update='sudo dnf update -y'
elif [[ "\$ID" == "arch" ]]; then
    alias update='sudo pacman -Syu --noconfirm'
fi

# =============================
# FUNÇÕES
# =============================
mostrar() {
    alias "\$1"
}

$END_MARK
EOF

    success ".bashrc configurado com sucesso."
}

# =============================
# ORQUESTRAÇÃO
# =============================

setup_bashrc() {
    remove_old_block
    append_new_block
}