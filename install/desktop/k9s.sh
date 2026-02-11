#!/bin/zsh

set -e

if command -v k9s >/dev/null 2>&1; then
    rm -rf ~/.config/k9s
    cp -R ~/.local/share/macdots/configs/k9s ~/.config/k9s

    # Install Catppuccin theme
    source ~/.local/share/macdots/theme/k9s.sh
fi
