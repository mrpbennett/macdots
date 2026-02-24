#!/bin/zsh

curl -fsSL https://claude.ai/install.sh | bash

[ -d "$HOME/.claude" ] || mkdir -p "$HOME/.claude"
cp "$HOME/.local/macdots/ai/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
