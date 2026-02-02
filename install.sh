#!/bin/zsh
#
# macdots Installation Script
# Orchestrates the installation of all macdots components
#

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the core library
source "${SCRIPT_DIR}/lib/core.sh"

# ==============================================================================
# Configuration
# ==============================================================================

# Installation flags
INSTALL_HOMEBREW=false
INSTALL_TERMINAL=false
INSTALL_DESKTOP=false
INSTALL_SHELL=false
INSTALL_KEYBOARD=false
INSTALL_ALL=true
SKIP_BACKUP=false
DRY_RUN=false
FORCE=false
AUTO_YES=false

# ==============================================================================
# Parse Arguments
# ==============================================================================

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --homebrew)
                INSTALL_HOMEBREW=true
                INSTALL_ALL=false
                shift
                ;;
            --terminal)
                INSTALL_TERMINAL=true
                INSTALL_ALL=false
                shift
                ;;
            --desktop)
                INSTALL_DESKTOP=true
                INSTALL_ALL=false
                shift
                ;;
            --shell)
                INSTALL_SHELL=true
                INSTALL_ALL=false
                shift
                ;;
            --keyboard)
                INSTALL_KEYBOARD=true
                INSTALL_ALL=false
                shift
                ;;
            --all)
                INSTALL_ALL=true
                shift
                ;;
            --skip-backup)
                SKIP_BACKUP=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --force)
                FORCE=true
                shift
                ;;
            --yes|-y)
                AUTO_YES=true
                shift
                ;;
            --help|-h)
                show_install_help
                exit 0
                ;;
            *)
                macdots_error "Unknown option: $1"
                show_install_help
                exit 1
                ;;
        esac
    done
}

show_install_help() {
    cat << EOF
macdots install - Install macdots configuration

USAGE:
    install.sh [options]

OPTIONS:
    --all               Install everything (default)
    --homebrew          Install Homebrew and packages only
    --terminal          Install terminal tools only
    --desktop           Install desktop applications only
    --shell             Install shell configuration only
    --keyboard          Install keyboard customizations only
    --skip-backup       Skip creating backups of existing configs
    --dry-run           Show what would be done without executing
    --force             Force re-installation even if already installed
    --yes, -y           Skip confirmation prompts
    --help, -h          Show this help message

EXAMPLES:
    install.sh                          # Install everything
    install.sh --terminal               # Install only terminal tools
    install.sh --all --dry-run          # Preview what would be installed
    install.sh --shell --force          # Force re-install shell configs

EOF
}

# ==============================================================================
# Installation Functions
# ==============================================================================

install_homebrew() {
    macdots_section "Installing Homebrew & Packages"
    
    if [[ "$DRY_RUN" == true ]]; then
        macdots_info "[DRY RUN] Would install Homebrew and packages from Brewfile"
        return 0
    fi
    
    if [[ -f "${MACDOTS_ROOT}/install/homebrew/homebrew.sh" ]]; then
        source "${MACDOTS_ROOT}/install/homebrew/homebrew.sh"
        macdots_mark_installed "homebrew"
    else
        macdots_warn "Homebrew installer not found, skipping..."
    fi
}

install_terminal() {
    macdots_section "Installing Terminal Tools"
    
    if [[ "$DRY_RUN" == true ]]; then
        macdots_info "[DRY RUN] Would run terminal installers"
        return 0
    fi
    
    if [[ -f "${MACDOTS_ROOT}/install/terminal.sh" ]]; then
        source "${MACDOTS_ROOT}/install/terminal.sh"
        macdots_mark_installed "terminal"
    else
        macdots_warn "Terminal installer not found, skipping..."
    fi
}

install_desktop() {
    macdots_section "Installing Desktop Tools"
    
    if [[ "$DRY_RUN" == true ]]; then
        macdots_info "[DRY RUN] Would run desktop installers"
        return 0
    fi
    
    if [[ -f "${MACDOTS_ROOT}/install/desktop.sh" ]]; then
        source "${MACDOTS_ROOT}/install/desktop.sh"
        macdots_mark_installed "desktop"
    else
        macdots_warn "Desktop installer not found, skipping..."
    fi
}

install_shell() {
    macdots_section "Installing Shell Configuration"
    
    if [[ "$DRY_RUN" == true ]]; then
        macdots_info "[DRY RUN] Would install shell configuration"
        return 0
    fi
    
    if [[ -f "${MACDOTS_ROOT}/install/shell.sh" ]]; then
        source "${MACDOTS_ROOT}/install/shell.sh"
        macdots_mark_installed "shell"
    else
        macdots_warn "Shell installer not found, skipping..."
    fi
}

install_keyboard() {
    macdots_section "Installing Keyboard Customizations"
    
    if [[ "$DRY_RUN" == true ]]; then
        macdots_info "[DRY RUN] Would install keyboard customizations"
        return 0
    fi
    
    if [[ -f "${MACDOTS_ROOT}/install/keyboard/karabiner.sh" ]]; then
        source "${MACDOTS_ROOT}/install/keyboard/karabiner.sh"
        macdots_mark_installed "keyboard"
    else
        macdots_warn "Keyboard installer not found, skipping..."
    fi
}

# ==============================================================================
# Main Installation
# ==============================================================================

main() {
    # Parse command line arguments
    parse_args "$@"
    
    # Initialize logging
    macdots_init_log
    
    # Show header
    macdots_section "macdots Installation"
    
    if [[ "$DRY_RUN" == true ]]; then
        macdots_info "DRY RUN MODE: No changes will be made"
        echo ""
    fi
    
    # Check prerequisites
    macdots_check_prerequisites
    
    # Show what will be installed
    macdots_info "Installation plan:"
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_HOMEBREW" == true ]]; then
        echo "  • Homebrew & packages"
    fi
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_TERMINAL" == true ]]; then
        echo "  • Terminal tools"
    fi
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_DESKTOP" == true ]]; then
        echo "  • Desktop applications"
    fi
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_SHELL" == true ]]; then
        echo "  • Shell configuration"
    fi
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_KEYBOARD" == true ]]; then
        echo "  • Keyboard customizations"
    fi
    echo ""
    
    # Confirm if not auto-yes
    if [[ "$AUTO_YES" != true ]] && [[ "$DRY_RUN" != true ]]; then
        if ! macdots_confirm "Continue with installation?"; then
            macdots_info "Installation cancelled"
            exit 0
        fi
    fi
    
    # Run installations
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_HOMEBREW" == true ]]; then
        install_homebrew
    fi
    
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_TERMINAL" == true ]]; then
        install_terminal
    fi
    
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_DESKTOP" == true ]]; then
        install_desktop
    fi
    
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_SHELL" == true ]]; then
        install_shell
    fi
    
    if [[ "$INSTALL_ALL" == true ]] || [[ "$INSTALL_KEYBOARD" == true ]]; then
        install_keyboard
    fi
    
    # Completion
    macdots_complete
}

# Run main function
main "$@"
