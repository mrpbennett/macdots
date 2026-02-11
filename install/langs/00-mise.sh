#!/bin/zsh

set -e

if command -v mise >/dev/null 2>&1; then
    echo "Setting up global language runtimes with mise..."

    # Install Go (needed by yaml.sh)
    mise use --global go@latest

    # Install Python (needed by python.sh)
    mise use --global python@latest

    echo "mise language runtimes installed successfully"
else
    echo "mise not found, skipping language runtime setup"
fi
