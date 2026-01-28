#!/bin/zsh

# -- Dock --

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock tilesize -int 37

# -- Trackpad --

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

# -- Finder --

# list view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep directories first
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
