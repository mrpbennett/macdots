#!/bin/zsh

set -e

# Source line to add to .zshrc
SOURCE_LINE="source ~/.local/share/macdots/defaults/zsh/rc"

# Create .zshrc if it doesn't exist
if [[ ! -f ~/.zshrc ]]; then
    touch ~/.zshrc
fi

# Add source line if not already present
if ! grep -Fxq "$SOURCE_LINE" ~/.zshrc; then
    echo "" >> ~/.zshrc
    echo "# macdots configuration" >> ~/.zshrc
    echo "$SOURCE_LINE" >> ~/.zshrc
    echo "Added macdots zsh configuration to ~/.zshrc"
else
    echo "macdots zsh configuration already present in ~/.zshrc"
fi
