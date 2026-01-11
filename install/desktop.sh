#!/bin/zsh

# Run desktop installers
for installer in ~/.local/share/macdots/install/desktop/*.sh; do source $installer; done
