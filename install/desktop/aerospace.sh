#!/bin/zsh

set -e

if command -v aerospace >/dev/null 2>&1; then
    rm -rf ~/.config/aerospace
    cp -R ~/.local/share/macdots/configs/aerospace ~/.config/aerospace
fi
