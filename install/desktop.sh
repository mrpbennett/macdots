#!/bin/zsh
#
# Desktop Applications Installation Orchestrator
# Runs all desktop installer scripts
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

macdots_section "Installing Desktop Applications"

macdots_run_installers "${MACDOTS_ROOT}/install/desktop"

# Also run macOS system defaults
if [[ -f "${MACDOTS_ROOT}/install/system/macos.sh" ]]; then
    source "${MACDOTS_ROOT}/install/system/macos.sh"
fi
