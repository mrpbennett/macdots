# Installation Guide

## Quick Start

### Fresh Install

Run the bootstrap script to clone and install everything:

```bash
curl -fsSL https://raw.githubusercontent.com/mrpbennett/macdots/main/boot.sh | zsh
```

### Manual Install (if already cloned)

```bash
# Install everything
macdots install

# Or install specific components
macdots install --terminal    # Terminal tools only
macdots install --desktop     # Desktop apps only
macdots install --shell       # Shell configuration only
```

## Installation Options

The `install.sh` script (and `macdots install` command) support these flags:

- `--all` - Install everything (default)
- `--homebrew` - Install Homebrew and packages only
- `--terminal` - Install terminal tools only
- `--desktop` - Install desktop applications only
- `--shell` - Install shell configuration only
- `--keyboard` - Install keyboard customizations only
- `--skip-backup` - Skip creating backups of existing configs
- `--dry-run` - Show what would be done without executing
- `--force` - Force re-installation even if already installed
- `--yes, -y` - Skip confirmation prompts

## What Gets Installed

### Homebrew & Packages
- Homebrew (if not present)
- All packages from `install/homebrew/Brewfile`

### Terminal Tools
- Neovim (LazyVim-based configuration)
- Zsh with Oh-My-Zsh
- Kubernetes tools (kubectl, k9s, helm)
- AWS CLI
- UV Python package manager
- Krew (kubectl plugin manager)
- Various CLI utilities (eza, bat, fzf, etc.)

### Desktop Applications
- Zed Editor
- Aerospace window manager
- Ghostty terminal
- Karabiner-Elements (keyboard customization)

### Shell Configuration
- Zsh with Oh-My-Zsh
- Custom aliases and functions
- Vi mode
- Various plugins (autosuggestions, syntax highlighting)

### macOS System Defaults
- Dock settings
- Trackpad settings
- Finder preferences

## After Installation

1. **Restart your terminal** to load the new shell configuration
2. **Run `macdots doctor`** to verify everything is working
3. **Edit configurations** in `~/.local/share/macdots/configs/` - they're all symlinked!

## Troubleshooting

### Installation failed

Check the log file for details:
```bash
cat ~/.local/share/macdots/install.log
```

### Restore from backup

If something went wrong, restore from backup:
```bash
macdots restore              # See available backups
macdots restore 20250202-143022   # Restore specific backup
```

### Start fresh

To completely remove macdots and start over:
```bash
macdots uninstall            # Remove all symlinks
rm -rf ~/.local/share/macdots   # Delete the repository
```

## Updating macdots

To update to the latest version:

```bash
macdots update
```

This will:
1. Pull the latest changes from git
2. Re-run the installer

## Symlink Strategy

All configurations are **symlinked** from `~/.local/share/macdots/configs/` to their appropriate locations:

- `~/.config/nvim` → `~/.local/share/macdots/configs/nvim`
- `~/.config/zed` → `~/.local/share/macdots/configs/zed`
- `~/.config/aerospace` → `~/.local/share/macdots/configs/aerospace`
- `~/.config/yazi` → `~/.local/share/macdots/configs/yazi`
- `~/.config/k9s` → `~/.local/share/macdots/configs/k9s`
- `~/.config/zsh` → `~/.local/share/macdots/configs/zsh`

This means you can edit files directly in `~/.local/share/macdots/configs/` and the changes are live immediately!
