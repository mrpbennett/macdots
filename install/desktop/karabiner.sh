#!/bin/zsh

set -e

echo "Checking for Karabiner-Elements..."

# Check if Karabiner-Elements is already installed
if [[ -d "/Applications/Karabiner-Elements.app" ]] || command -v karabiner >/dev/null 2>&1; then
    echo "Karabiner-Elements is already installed."

    # Copy configuration if it exists
    if [[ -d ~/.local/share/macdots/defaults/karabiner ]]; then
        echo "Installing Karabiner-Elements configuration..."
        mkdir -p ~/.config/karabiner
        cp -R ~/.local/share/macdots/defaults/karabiner/* ~/.config/karabiner/
        echo "Karabiner-Elements configuration installed successfully!"
    else
        echo "No Karabiner-Elements configuration found in macdots defaults, skipping..."
    fi
else
    echo "Karabiner-Elements not found. Downloading latest version..."

    # Create temporary directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    # Download the latest version
    echo "Downloading from https://karabiner-elements.pqrs.org/..."
    curl -L -o karabiner-elements.dmg "https://github.com/pqrs-org/Karabiner-Elements/releases/latest/download/Karabiner-Elements.dmg"

    # Mount the DMG
    echo "Mounting DMG..."
    hdiutil attach karabiner-elements.dmg -quiet

    # Find the mounted volume
    VOLUME_PATH="/Volumes/Karabiner-Elements"
    if [[ ! -d "$VOLUME_PATH" ]]; then
        # Try to find the actual volume name
        VOLUME_PATH=$(ls /Volumes | grep -i karabiner | head -1)
        VOLUME_PATH="/Volumes/$VOLUME_PATH"
    fi

    # Copy the app to Applications
    echo "Installing Karabiner-Elements..."
    cp -R "$VOLUME_PATH/Karabiner-Elements.app" "/Applications/"

    # Unmount the DMG
    echo "Cleaning up..."
    hdiutil detach "$VOLUME_PATH" -quiet

    # Clean up temporary files
    cd /
    rm -rf "$TEMP_DIR"

    echo "Karabiner-Elements has been successfully installed!"

    # Copy configuration if it exists
    if [[ -d ~/.local/share/macdots/defaults/karabiner ]]; then
        echo "Installing Karabiner-Elements configuration..."
        mkdir -p ~/.config/karabiner
        cp -R ~/.local/share/macdots/defaults/karabiner/* ~/.config/karabiner/
        echo "Karabiner-Elements configuration installed successfully!"
    else
        echo "No Karabiner-Elements configuration found in macdots defaults, skipping..."
    fi

    echo "Note: You may need to grant accessibility permissions to Karabiner-Elements in System Settings > Privacy & Security > Accessibility"
fi
