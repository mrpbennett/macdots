# macdots

A lightweight macOS dotfiles management system with **symlink-based** configurations for easy live editing.

## Quick Start

Install everything on a fresh Mac:

```bash
curl -fsSL https://raw.githubusercontent.com/mrpbennett/macdots/main/boot.sh | zsh
```

## What's Included

**Editors**: Neovim (LazyVim), Zed  
**Terminal**: Ghostty, Zsh (Oh-My-Zsh)  
**Tools**: Kubernetes (kubectl, k9s, helm), AWS CLI, UV, Krew  
**Desktop**: Aerospace (tiling manager), Karabiner-Elements  
**Shell**: Custom aliases, vi-mode, autosuggestions, syntax highlighting

## Usage

```bash
# Install everything
macdots install

# Install specific components
macdots install --terminal
macdots install --desktop
macdots install --shell

# Check status
macdots doctor
macdots status

# Update to latest
macdots update

# Backup/restore
macdots backup
macdots restore <timestamp>

# Uninstall
macdots uninstall
```

## Why Symlinks?

All configs in `~/.local/share/macdots/configs/` are **symlinked** to system locations:

```
~/.config/nvim → ~/.local/share/macdots/configs/nvim
~/.config/zed  → ~/.local/share/macdots/configs/zed
```

**Benefits**:
- Edit in one place
- Changes are immediately live
- Track everything in git
- Easy to sync across machines

## Customization

Edit files directly in `~/.local/share/macdots/configs/`:

- `configs/zsh/` - Shell configuration
- `configs/nvim/` - Neovim setup
- `configs/zed/` - Zed editor settings
- `configs/aerospace/` - Window manager

See [docs/customization.md](docs/customization.md) for details.

## Documentation

- [Installation Guide](docs/install.md) - Detailed installation instructions
- [Customization Guide](docs/customization.md) - How to modify configurations

## Requirements

- macOS (Apple Silicon or Intel)
- Internet connection
- Git

## License

MIT
