#!/bin/zsh

set -e

# Force non-interactive git to avoid credential prompts in unattended installs.
export GIT_TERMINAL_PROMPT=0
export GIT_ASKPASS=/usr/bin/true
export GCM_INTERACTIVE=never


echo "Cloning macdots..."
rm -rf ~/.local/share/macdots
if ! git clone https://github.com/mrpbennett/macdots.git ~/.local/share/macdots; then
    echo "Failed to clone macdots repository"
    exit 1
fi
if [[ $macdots_REF != "master" ]]; then
	cd ~/.local/share/macdots
	git fetch origin "${macdots_REF:-stable}" && git checkout "${macdots_REF:-stable}"
	cd -
fi

echo "Installation starting..."
if ! source ~/.local/share/macdots/install.sh; then
    echo "Installation failed! Check the error messages above."
    exit 1
fi
