#!/usr/bin/env bash

SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
SSH_PUB_KEY_PATH="$SSH_KEY_PATH.pub"

# =============================
# VERIFICAÇÃO
# =============================

ssh_key_exists() {
    [[ -f "$SSH_KEY_PATH" && -f "$SSH_PUB_KEY_PATH" ]]
}

# =============================
# INTERAÇÃO
# =============================

ask_generate_ssh_key() {
    echo ""
    read -r -p "Deseja gerar uma chave SSH (ed25519)? [y/N]: " response
    [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
}

ask_ssh_email() {
    echo ""
    read -r -p "Informe o e-mail para a chave SSH: " SSH_EMAIL
}

# =============================
# GERAÇÃO
# =============================

generate_ssh_key() {
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f "$SSH_KEY_PATH"
}

# =============================
# EXIBIÇÃO
# =============================

show_ssh_public_key() {
    echo ""
    success "Chave SSH pública:"
    echo "--------------------------------------------------"
    cat "$SSH_PUB_KEY_PATH"
    echo "--------------------------------------------------"
}

# =============================
# ORQUESTRAÇÃO
# =============================

setup_ssh() {
    if ssh_key_exists; then
        info "Chave SSH ed25519 já existe."

        if ask_generate_ssh_key; then
            ask_ssh_email
            generate_ssh_key
            show_ssh_public_key
        else
            info "Mantendo chave SSH existente."
            show_ssh_public_key
        fi
    else
        if ask_generate_ssh_key; then
            ask_ssh_email
            generate_ssh_key
            show_ssh_public_key
        else
            warn "Nenhuma chave SSH foi gerada."
        fi
    fi
}