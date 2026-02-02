#!/bin/zsh
#
# Yazi File Manager Configuration Installer
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if command -v yazi >/dev/null 2>&1; then
    macdots_step "Installing Yazi configuration..."
    
    # Use symlink instead of copy for live editing
    macdots_symlink "${MACDOTS_ROOT}/configs/yazi" "${HOME}/.config/yazi"
    
    macdots_success "Yazi configuration installed"
else
    macdots_warn "Yazi not found, skipping configuration"
fi
