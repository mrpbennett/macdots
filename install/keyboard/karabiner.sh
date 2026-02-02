#!/bin/zsh
#
# Karabiner-Elements Configuration Installer
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

macdots_step "Checking for Karabiner-Elements..."

# Check if Karabiner-Elements is already installed
if [[ -d "/Applications/Karabiner-Elements.app" ]] || command -v karabiner >/dev/null 2>&1; then
    macdots_info "Karabiner-Elements is already installed"

    # Symlink configuration if it exists
    if [[ -d "${MACDOTS_ROOT}/configs/karabiner" ]]; then
        macdots_step "Installing Karabiner-Elements configuration..."
        
        # Ensure the config directory exists
        mkdir -p "${HOME}/.config"
        
        # Use symlink for the entire karabiner directory
        macdots_symlink "${MACDOTS_ROOT}/configs/karabiner" "${HOME}/.config/karabiner"
        
        macdots_success "Karabiner-Elements configuration installed"
    else
        macdots_warn "No Karabiner-Elements configuration found in macdots configs"
    fi
else
    macdots_warn "Karabiner-Elements not found"
    macdots_info "Install it via: brew install --cask karabiner-elements"
    macdots_info "Or download from: https://karabiner-elements.pqrs.org/"
fi
