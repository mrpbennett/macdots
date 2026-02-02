#!/bin/zsh
#
# K9s Kubernetes CLI Configuration Installer
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if command -v k9s >/dev/null 2>&1; then
    macdots_step "Installing K9s configuration..."
    
    # Use symlink instead of copy for live editing
    macdots_symlink "${MACDOTS_ROOT}/configs/k9s" "${HOME}/.config/k9s"
    
    macdots_success "K9s configuration installed"
else
    macdots_warn "K9s not found, skipping configuration"
fi
