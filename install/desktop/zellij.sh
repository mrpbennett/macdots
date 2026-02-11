#!/bin/zsh

set -e

if command -v zellij >/dev/null 2>&1; then
    rm -rf ~/.config/zellij
    cp -R ~/.local/share/macdots/configs/zellij ~/.config/zellij
fi
