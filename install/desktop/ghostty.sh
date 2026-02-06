#!/bin/zsh

# Source the core library
SCRIPT_DIR="${0:A:h}"
source "${SCRIPT_DIR}/../../lib/core.sh"

macdots_info "Setting up Ghostty configuration..."

# Symlink Ghostty config directory
macdots_symlink "${MACDOTS_ROOT}/configs/ghostty" "$HOME/.config/ghostty"

macdots_success "Ghostty configuration symlinked successfully"
macdots_mark_installed "ghostty"
