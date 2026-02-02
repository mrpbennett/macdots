#!/bin/zsh
#
# macdots Core Library
# Shared functions for all macdots scripts
#

# ==============================================================================
# Constants
# ==============================================================================

export MACDOTS_ROOT="${HOME}/.local/share/macdots"
export MACDOTS_BACKUP_DIR="${HOME}/.local/share/macdots/backups"
export MACDOTS_LOG_FILE="${HOME}/.local/share/macdots/install.log"

# Colors for output
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export NC='\033[0m' # No Color

# ==============================================================================
# Logging Functions
# ==============================================================================

# Initialize log file
macdots_init_log() {
    local log_dir
    log_dir="$(dirname "$MACDOTS_LOG_FILE")"
    
    if [[ ! -d "$log_dir" ]]; then
        mkdir -p "$log_dir"
    fi
    
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] macdots installation started" >> "$MACDOTS_LOG_FILE"
}

# Log message to both console and file
macdots_log() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    # Write to log file
    echo "[${timestamp}] [${level}] ${message}" >> "$MACDOTS_LOG_FILE"
    
    # Write to console with colors
    case "$level" in
        ERROR)
            echo -e "${RED}✗${NC} ${message}" >&2
            ;;
        WARN)
            echo -e "${YELLOW}⚠${NC} ${message}"
            ;;
        SUCCESS)
            echo -e "${GREEN}✓${NC} ${message}"
            ;;
        INFO)
            echo -e "${BLUE}ℹ${NC} ${message}"
            ;;
        STEP)
            echo -e "${BLUE}→${NC} ${message}"
            ;;
    esac
}

# Convenience functions
macdots_info() { macdots_log "INFO" "$1"; }
macdots_warn() { macdots_log "WARN" "$1"; }
macdots_error() { macdots_log "ERROR" "$1"; }
macdots_success() { macdots_log "SUCCESS" "$1"; }
macdots_step() { macdots_log "STEP" "$1"; }

# ==============================================================================
# Platform Detection
# ==============================================================================

macdots_is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

macdots_is_apple_silicon() {
    [[ "$(uname -m)" == "arm64" ]]
}

macdots_check_macos() {
    if ! macdots_is_macos; then
        macdots_error "This script is designed for macOS only. Detected OS: $(uname)"
        exit 1
    fi
}

# ==============================================================================
# Prerequisite Checks
# ==============================================================================

macdots_check_prerequisites() {
    # Check if running on macOS
    macdots_check_macos
    
    # Check if macdots directory exists
    if [[ ! -d "$MACDOTS_ROOT" ]]; then
        macdots_error "macdots directory not found at $MACDOTS_ROOT"
        macdots_info "Please run boot.sh first to clone the repository."
        exit 1
    fi
    
    macdots_success "Prerequisites check passed"
}

# Check if a command exists
macdots_command_exists() {
    command -v "$1" &> /dev/null
}

# ==============================================================================
# Backup Functions
# ==============================================================================

# Create timestamped backup of a file or directory
macdots_backup() {
    local source="$1"
    local backup_name
    backup_name="$(basename "$source")"
    local timestamp
    timestamp=$(date '+%Y%m%d-%H%M%S')
    local backup_path="${MACDOTS_BACKUP_DIR}/${timestamp}/${backup_name}"
    
    if [[ -e "$source" ]]; then
        # Create backup directory if it doesn't exist
        mkdir -p "$(dirname "$backup_path")"
        
        # Copy to backup location
        if cp -R "$source" "$backup_path" 2>/dev/null; then
            macdots_info "Backed up ${source} → ${backup_path}"
            return 0
        else
            macdots_warn "Failed to backup ${source}"
            return 1
        fi
    fi
    
    return 0
}

# ==============================================================================
# Symlink Management
# ==============================================================================

# Create a symlink from source to target, backing up existing target if needed
macdots_symlink() {
    local source="$1"
    local target="$2"
    local backup_first="${3:-true}"
    
    # Check if source exists
    if [[ ! -e "$source" ]]; then
        macdots_error "Source does not exist: $source"
        return 1
    fi
    
    # If target exists and is already a symlink to source, do nothing
    if [[ -L "$target" ]]; then
        local current_source
        current_source="$(readlink "$target")"
        if [[ "$current_source" == "$source" ]]; then
            macdots_info "Symlink already exists: $target → $source"
            return 0
        fi
    fi
    
    # Backup existing target if requested
    if [[ "$backup_first" == "true" && -e "$target" ]]; then
        macdots_backup "$target"
        rm -rf "$target"
    fi
    
    # Create parent directory if needed
    local target_dir
    target_dir="$(dirname "$target")"
    if [[ ! -d "$target_dir" ]]; then
        mkdir -p "$target_dir"
    fi
    
    # Create the symlink
    if ln -sf "$source" "$target"; then
        macdots_success "Created symlink: $target → $source"
        return 0
    else
        macdots_error "Failed to create symlink: $target → $source"
        return 1
    fi
}

# Remove a symlink safely (only if it's actually a symlink)
macdots_remove_symlink() {
    local target="$1"
    
    if [[ -L "$target" ]]; then
        rm "$target"
        macdots_info "Removed symlink: $target"
        return 0
    elif [[ -e "$target" ]]; then
        macdots_warn "Not a symlink, skipping removal: $target"
        return 1
    fi
    
    return 0
}

# Verify a symlink points to the correct source
macdots_verify_symlink() {
    local target="$1"
    local expected_source="$2"
    
    if [[ ! -L "$target" ]]; then
        macdots_error "Not a symlink: $target"
        return 1
    fi
    
    local actual_source
    actual_source="$(readlink "$target")"
    
    if [[ "$actual_source" != "$expected_source" ]]; then
        macdots_error "Symlink mismatch: $target"
        macdots_info "  Expected: $expected_source"
        macdots_info "  Actual: $actual_source"
        return 1
    fi
    
    return 0
}

# ==============================================================================
# Idempotency Helpers
# ==============================================================================

# Check if a component is already installed
macdots_is_installed() {
    local component="$1"
    local state_file="${MACDOTS_ROOT}/.install_state"
    
    if [[ -f "$state_file" ]]; then
        grep -q "^${component}$" "$state_file" 2>/dev/null
        return $?
    fi
    
    return 1
}

# Mark a component as installed
macdots_mark_installed() {
    local component="$1"
    local state_file="${MACDOTS_ROOT}/.install_state"
    
    if [[ ! -f "$state_file" ]]; then
        touch "$state_file"
    fi
    
    if ! grep -q "^${component}$" "$state_file" 2>/dev/null; then
        echo "$component" >> "$state_file"
    fi
}

# ==============================================================================
# Installation Helpers
# ==============================================================================

# Install Homebrew if not present
macdots_ensure_homebrew() {
    if macdots_command_exists brew; then
        macdots_info "Homebrew is already installed"
        return 0
    fi
    
    macdots_step "Installing Homebrew..."
    
    # Install Xcode Command Line Tools (required for Homebrew)
    xcode-select --install 2>/dev/null || true
    
    # Install Homebrew
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        # Ensure brew is on PATH (Apple Silicon)
        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        macdots_success "Homebrew installed successfully"
        return 0
    else
        macdots_error "Failed to install Homebrew"
        return 1
    fi
}

# Run all installers in a directory
macdots_run_installers() {
    local install_dir="$1"
    local count=0
    
    if [[ ! -d "$install_dir" ]]; then
        macdots_warn "Install directory not found: $install_dir"
        return 0
    fi
    
    for installer in "$install_dir"/*.sh; do
        if [[ -f "$installer" ]]; then
            macdots_step "Running $(basename "$installer")..."
            if source "$installer"; then
                ((count++))
            else
                macdots_warn "Installer failed: $(basename "$installer")"
            fi
        fi
    done
    
    macdots_info "Ran $count installers from $install_dir"
}

# ==============================================================================
# User Interaction
# ==============================================================================

# Ask user for confirmation
macdots_confirm() {
    local message="$1"
    local response
    
    echo -en "${YELLOW}?${NC} ${message} [y/N] "
    read -r response
    
    [[ "$response" =~ ^[Yy]$ ]]
}

# ==============================================================================
# Utility Functions
# ==============================================================================

# Print section header
macdots_section() {
    local title="$1"
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  ${title}${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Print completion message
macdots_complete() {
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ✓ Installation Complete!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    macdots_info "Backups stored in: $MACDOTS_BACKUP_DIR"
    macdots_info "Log file: $MACDOTS_LOG_FILE"
}
