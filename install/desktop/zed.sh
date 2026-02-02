#!/bin/zsh
#
# Zed Editor Configuration Installer
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

# Check if Zed is already installed
if [[ -d "/Applications/Zed.app" ]] || command -v zed >/dev/null 2>&1; then
    macdots_step "Installing Zed configuration..."
    
    # Use symlink instead of copy for live editing
    macdots_symlink "${MACDOTS_ROOT}/configs/zed" "${HOME}/.config/zed"
    
    macdots_success "Zed configuration installed"
else
    macdots_warn "Zed not found, skipping configuration"
fi
