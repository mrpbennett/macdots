#!/bin/zsh

set -e

if command -v yazi >/dev/null 2>&1; then
    rm -rf ~/.config/yazi
    cp -R ~/.local/share/macdots/configs/yazi ~/.config/yazi
fi
