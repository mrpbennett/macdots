#!/bin/zsh

set -euo pipefail

for installer in ~/.local/share/macdots/install/terminal/*.sh; do source $installer; done
