#!/bin/zsh

set -euo pipefail

# 1) Xcode Command Line Tools (required for Homebrew)
xcode-select --install >/dev/null 2>&1 || true

# 2) Install Homebrew if missing
if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 3) Ensure brew is on PATH (Apple Silicon)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 4) Install from Brewfile
brew update
brew bundle --file ~/.local/share/macdots/install/homebrew/Brewfile
