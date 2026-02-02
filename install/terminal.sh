#!/bin/zsh
#
# Terminal Tools Installation Orchestrator
# Runs all terminal installer scripts
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

macdots_section "Installing Terminal Tools"

macdots_run_installers "${MACDOTS_ROOT}/install/terminal"
