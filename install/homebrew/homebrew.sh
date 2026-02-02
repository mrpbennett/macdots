#!/bin/zsh
#
# Homebrew Installation Script
# Installs Homebrew and all packages from Brewfile
#

set -euo pipefail

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

# 1) Xcode Command Line Tools (required for Homebrew)
macdots_step "Checking Xcode Command Line Tools..."
xcode-select --install >/dev/null 2>&1 || true

# 2) Install Homebrew if missing
if ! command -v brew >/dev/null 2>&1; then
    macdots_step "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    macdots_success "Homebrew installed"
else
    macdots_info "Homebrew is already installed"
fi

# 3) Ensure brew is on PATH (Apple Silicon)
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 4) Install from Brewfile
macdots_step "Installing packages from Brewfile..."
brew update
if brew bundle --file "${MACDOTS_ROOT}/install/homebrew/Brewfile"; then
    macdots_success "Homebrew packages installed"
else
    macdots_warn "Some packages may have failed to install"
fi
