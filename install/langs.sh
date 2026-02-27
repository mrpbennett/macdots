#!/bin/zsh

set -euo pipefail

# Run desktop installers
for installer in ~/.local/share/macdots/install/langs/*.sh; do source $installer; done
