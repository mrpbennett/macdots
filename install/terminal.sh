#!/bin/zsh


# Run terminal installers
for installer in ~/.local/share/macdots/install/terminal/*.sh; do
    if [[ -f "$installer" ]]; then
        echo "Running $(basename "$installer")..."
        if ! source "$installer"; then
            echo "Warning: Failed to run $(basename "$installer"). Continuing with installation..."
        fi
    fi
done
