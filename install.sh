#!/bin/zsh

# Exit immediately if a command exits with a non-zero status
set -e

# Validate that we're running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
  echo "Error: This script is designed for macOS only. Detected OS: $(uname)"
  echo "Please use the appropriate installation script for your operating system."
  exit 1
fi

# Check if macdots directory exists
if [[ ! -d ~/.local/share/macdots ]]; then
  echo "Error: macdots directory not found at ~/.local/share/macdots"
  echo "Please run boot.sh first to clone the repository."
  exit 1
fi

echo "Installing terminal and desktop tools for macOS..."

# Install Homebrew and basic dependencies
echo "Step 1/3: Installing Homebrew..."
if [[ -f ~/.local/share/macdots/install/homebrew/homebrew.sh ]]; then
  source ~/.local/share/macdots/install/homebrew/homebrew.sh
else
  echo "Warning: Homebrew installer not found, skipping..."
fi

# Install Terminal tools and tweaks
echo "Step 2/3: Installing terminal tools..."
if [[ -f ~/.local/share/macdots/install/terminal.sh ]]; then
  source ~/.local/share/macdots/install/terminal.sh
else
  echo "Warning: Terminal installer not found, skipping..."
fi

# Install Desktop tools and tweaks
echo "Step 3/3: Installing desktop tools..."
if [[ -f ~/.local/share/macdots/install/desktop.sh ]]; then
  source ~/.local/share/macdots/install/desktop.sh
else
  echo "Warning: Desktop installer not found, skipping..."
fi

# Install keyboard customizations (if available)
if [[ -f ~/.local/share/macdots/install/keyboard/macos-keyboard.sh ]]; then
  echo "Installing keyboard customizations..."
  source ~/.local/share/macdots/install/keyboard/macos-keyboard.sh
fi

echo "Installation completed successfully!"
