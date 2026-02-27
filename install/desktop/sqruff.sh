#!/bin/zsh

set -e

if command -v sqruff >/dev/null 2>&1; then
    rm -rf ~/.config/sqruff
    cp -R ~/.local/share/macdots/configs/sqruff ~/.config/sqruff
fi
