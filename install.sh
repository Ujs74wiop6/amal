#!/bin/bash

set -euo pipefail

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$BASE_DIR/lib/core.sh"
source "$BASE_DIR/lib/distro.sh"
source "$BASE_DIR/lib/packages.sh"
source "$BASE_DIR/lib/docker.sh"
source "$BASE_DIR/lib/python.sh"
source "$BASE_DIR/lib/ssh.sh"
source "$BASE_DIR/lib/bashrc.sh"

main() {
    detect_distro
    update_system
    install_packages
    setup_docker
    setup_python
    setup_ssh
    setup_bashrc
}

main "$@"