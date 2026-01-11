#!/bin/zsh


# -- Finder --

# list view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Keep directories first
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
