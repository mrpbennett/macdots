#!/bin/zsh

# Source the core library
SCRIPT_DIR="${0:A:h}"
source "${SCRIPT_DIR}/../../lib/core.sh"

macdots_info "Installing mise..."

# Check if mise is already installed
if macdots_command_exists mise; then
    macdots_success "mise is already installed"
else
    macdots_info "Installing mise via curl..."
    if curl https://mise.run | sh; then
        macdots_success "mise installed successfully"
    else
        macdots_error "Failed to install mise"
        return 1
    fi
fi

# Symlink mise config directory
macdots_info "Creating mise config symlink..."
macdots_symlink "${MACDOTS_ROOT}/configs/mise" "$HOME/.config/mise"

# Set global tool versions
macdots_info "Setting global tool versions..."
if command -v mise &> /dev/null || [ -x "$HOME/.local/bin/mise" ]; then
    MISE_BIN="${HOME}/.local/bin/mise"
    $MISE_BIN use --global python@latest
    $MISE_BIN use --global go@latest
    macdots_success "Global tool versions set"
else
    macdots_warn "mise not found in PATH, skipping global tool setup"
fi

macdots_mark_installed "mise"
