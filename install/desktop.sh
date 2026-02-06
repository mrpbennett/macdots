#!/bin/zsh
#
# Desktop Applications Installation Orchestrator
# Runs all desktop installer scripts
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

macdots_section "Installing Desktop Applications"

macdots_run_installers "${MACDOTS_ROOT}/install/desktop"
