#!/bin/zsh
#
# macOS System Defaults
# Applies macOS system preferences and settings
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

macdots_section "Applying macOS System Defaults"

# -- Dock --
macdots_step "Configuring Dock..."
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 37
macdots_success "Dock configured"

# -- Trackpad --
macdots_step "Configuring Trackpad..."

# Force Click and tracking speed (NSGlobalDomain)
defaults write -g com.apple.trackpad.forceClick -bool true
defaults write -g com.apple.trackpad.scaling -int 3

# Natural scrolling OFF (NSGlobalDomain)
defaults write -g com.apple.swipescrolldirection -bool false

# Right click - bottom right corner (built-in trackpad)
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false

# Right click - bottom right corner (Bluetooth trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false

macdots_success "Trackpad configured"

# -- Finder --
macdots_step "Configuring Finder..."

# list view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep directories first
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

macdots_success "Finder configured"

# Restart affected applications
macdots_step "Restarting affected applications..."
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

macdots_success "macOS system defaults applied"
