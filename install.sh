#!/bin/zsh

# Exit immediately if a command exits with a non-zero status
set -e



# Check if macdots directory exists
if [[ ! -d ~/.local/share/macdots ]]; then
  echo "Error: macdots directory not found at ~/.local/share/macdots"
  echo "Please run boot.sh first to clone the repository."
  exit 1
fi

echo "Installing Homebrew and brews."
source ~/.local/share/macdots/install/homebrew/homebrew.sh

echo "Installing non Homebrew CLI tools"
source ~/.local/share/macdots/install/terminal.sh

echo "Installing Desktop Apps"
source ~/.local/share/macdots/install/desktop.sh

echo "Installing language tooling"
source ~/.local/share/macdots/install/langs.sh

echo "Setting macOS defaults"
source ~/.local/share/macdots/defaults/macos.sh

echo "Setting up application configs"
source ~/.local/share/macdots/defaults/apps.sh
