#!/bin/zsh
#
# Neovim (LazyVim) Configuration Installer
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if command -v nvim >/dev/null 2>&1; then
    macdots_step "Installing Neovim configuration..."
    
    # Backup existing nvim state directories
    if [ -d ~/.local/share/nvim ]; then
        macdots_backup ~/.local/share/nvim
        rm -rf ~/.local/share/nvim
    fi
    if [ -d ~/.local/state/nvim ]; then
        macdots_backup ~/.local/state/nvim
        rm -rf ~/.local/state/nvim
    fi
    if [ -d ~/.cache/nvim ]; then
        macdots_backup ~/.cache/nvim
        rm -rf ~/.cache/nvim
    fi
    
    # Use symlink for the nvim config directory for live editing
    macdots_symlink "${MACDOTS_ROOT}/configs/nvim" "${HOME}/.config/nvim"
    
    macdots_success "Neovim configuration installed"
    macdots_info "Run 'nvim' to start and let LazyVim install plugins"
else
    macdots_warn "Neovim not found, skipping configuration"
fi
