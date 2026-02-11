#!/bin/zsh

set -euo pipefail

# Skip if uv is already installed
if command -v uv >/dev/null 2>&1; then
    echo "uv is already installed"
    exit 0
fi

curl -LsSf https://astral.sh/uv/install.sh | sh
