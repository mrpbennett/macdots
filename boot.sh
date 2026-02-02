#!/bin/zsh
#
# macdots Bootstrap Script
# Clones the repository and starts installation
#
# Usage: curl -fsSL https://raw.githubusercontent.com/mrpbennett/macdots/main/boot.sh | zsh
#

set -e

# Force non-interactive git to avoid credential prompts in unattended installs.
export GIT_TERMINAL_PROMPT=0
export GIT_ASKPASS=/usr/bin/true
export GCM_INTERACTIVE=never

echo "🚀 macdots Bootstrap"
echo "===================="
echo ""

# Validate macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ Error: This script is designed for macOS only. Detected OS: $(uname)"
    exit 1
fi

echo "📦 Cloning macdots repository..."
rm -rf ~/.local/share/macdots

if ! git clone https://github.com/mrpbennett/macdots.git ~/.local/share/macdots 2>&1; then
    echo "❌ Failed to clone macdots repository"
    exit 1
fi

echo "✓ Repository cloned to ~/.local/share/macdots"

# Checkout specific ref if requested
if [[ -n "${macdots_REF:-}" ]] && [[ "$macdots_REF" != "main" ]] && [[ "$macdots_REF" != "master" ]]; then
    echo "🔄 Checking out ref: $macdots_REF"
    cd ~/.local/share/macdots
    git fetch origin "$macdots_REF" && git checkout "$macdots_REF"
    cd -
    echo "✓ Checked out $macdots_REF"
fi

echo ""
echo "🔧 Starting installation..."
echo ""

# Run the installation
if ~/.local/share/macdots/bin/macdots install "$@"; then
    echo ""
    echo "✅ Installation complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal"
    echo "  2. Run 'macdots doctor' to verify everything is working"
    echo "  3. Edit configs in ~/.local/share/macdots/configs/ (they're symlinked)"
    echo ""
else
    echo ""
    echo "❌ Installation failed! Check the error messages above."
    exit 1
fi
