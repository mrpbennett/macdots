#!/bin/zsh
#
# UV Python Package Manager Installer
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if ! command -v uv >/dev/null 2>&1; then
    macdots_step "Installing UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    macdots_success "UV installed"
else
    macdots_info "UV is already installed"
fi
