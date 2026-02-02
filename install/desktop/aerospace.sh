#!/bin/zsh
#
# Aerospace Window Manager Configuration Installer
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if command -v aerospace >/dev/null 2>&1; then
    macdots_step "Installing Aerospace configuration..."
    
    # Use symlink instead of copy for live editing
    macdots_symlink "${MACDOTS_ROOT}/configs/aerospace" "${HOME}/.config/aerospace"
    
    macdots_success "Aerospace configuration installed"
else
    macdots_warn "Aerospace not found, skipping configuration"
fi
