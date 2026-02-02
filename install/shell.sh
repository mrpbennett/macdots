#!/bin/zsh
#
# Shell Configuration Installer
# Sets up Zsh with Oh-My-Zsh and macdots configurations
#

set -e

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

macdots_section "Configuring Shell"

# Check if zsh is installed
if ! command -v zsh >/dev/null 2>&1; then
    macdots_error "Zsh is not installed. Please install it first."
    exit 1
fi

# Install Oh-My-Zsh if not present
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    macdots_step "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    macdots_success "Oh-My-Zsh installed"
else
    macdots_info "Oh-My-Zsh is already installed"
fi

# Create ZSH configuration directory symlink
macdots_step "Setting up Zsh configuration..."

# Ensure the config directory exists
if [[ ! -d "$HOME/.config" ]]; then
    mkdir -p "$HOME/.config"
fi

# Symlink the entire zsh config directory
macdots_symlink "${MACDOTS_ROOT}/configs/zsh" "$HOME/.config/zsh"

# Create .zshrc that sources our config
ZSHRC_CONTENT='export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export TERM=xterm-256color
export POETRY_VIRTUALENVS_IN_PROJECT=true

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# vi mode
bindkey -v
export KEYTIMEOUT=1

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR=\'vim\'
else
   export EDITOR=\'nvim\'
fi

# Source macdots zsh configuration
source ~/.config/zsh/rc
'

# Backup existing .zshrc if it exists
if [[ -f "$HOME/.zshrc" ]] && [[ ! -L "$HOME/.zshrc" ]]; then
    macdots_backup "$HOME/.zshrc"
    rm "$HOME/.zshrc"
fi

# Create .zshrc
if [[ ! -e "$HOME/.zshrc" ]] || [[ -L "$HOME/.zshrc" ]]; then
    echo "$ZSHRC_CONTENT" > "$HOME/.zshrc"
    macdots_success "Created .zshrc"
fi

# Install zsh-autosuggestions if not present
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
    macdots_step "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" 2>/dev/null || true
fi

# Install zsh-syntax-highlighting if not present
if [[ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
    macdots_step "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" 2>/dev/null || true
fi

# Change default shell to zsh if not already
if [[ "$SHELL" != "$(which zsh)" ]]; then
    macdots_step "Changing default shell to zsh..."
    chsh -s "$(which zsh)" || macdots_warn "Could not change default shell automatically"
fi

macdots_success "Shell configuration complete"
macdots_info "Please restart your terminal or run: source ~/.zshrc"
