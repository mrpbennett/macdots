#!/bin/zsh

set -euo pipefail

# Install Ruff globally
uv tool install ruff@latest

# Install ty globally
uv tool install ty@latest

# Install pipx
uv tool install pipx@latest
