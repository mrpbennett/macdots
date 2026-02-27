#!/bin/bash

curl -fsSL https://opencode.ai/install | bash

# Add superpowers for OpenCode
#
# 1. Install Superpowers (or update existing)
if [ -d ~/.config/opencode/superpowers ]; then
  cd ~/.config/opencode/superpowers && git pull
else
  git clone https://github.com/obra/superpowers.git ~/.config/opencode/superpowers
fi

# 2. Create directories
mkdir -p ~/.config/opencode/plugins ~/.config/opencode/skills

# 3. Remove old symlinks/directories if they exist
rm -f ~/.config/opencode/plugins/superpowers.js
rm -rf ~/.config/opencode/skills/superpowers

# 4. Create symlinks
ln -s ~/.config/opencode/superpowers/.opencode/plugins/superpowers.js ~/.config/opencode/plugins/superpowers.js
ln -s ~/.config/opencode/superpowers/skills ~/.config/opencode/skills/superpowers

# NOTES:
# Claude Code Compatibility
# For users migrating from Claude Code, OpenCode supports Claude Code’s file conventions as fallbacks:

# Project rules: CLAUDE.md in your project directory (used if no AGENTS.md exists)
# Global rules: ~/.claude/CLAUDE.md (used if no ~/.config/opencode/AGENTS.md exists)
# Skills: ~/.claude/skills/ — see Agent Skills for details
