# macdots Improvements

This document summarizes all the improvements made to the macdots project to fix critical bugs, wire up orphaned scripts, add missing functionality, and improve overall code quality.

---

## 1. Critical Bug Fixes

### install.sh

- **Line 16**: Fixed typo `install/homwbrew.sh` → `install/homebrew/homebrew.sh`
- This bug would have caused the entire install to fail immediately due to `set -e`

### defaults/apps.sh

- **Line 7**: Added `rm -rf ~/.config/nvim.bak` before `mv` to prevent failure on second run
- **Line 15**: Added `-R` flag to `cp` command for recursive directory copy of nvim config

### configs/nvim/lua/config/keymaps.lua

- **Line 10**: Fixed incomplete keymap `<CR` → `<CR>` (missing closing bracket)

### defaults/zsh/aliases

- Removed Linux-specific aliases that don't exist on macOS Homebrew:
  - Removed `alias bat='batcat'` (Homebrew uses `bat` directly)
  - Removed `alias fd='fdfind'` (Homebrew uses `fd` directly)
  - Updated fzf preview to use `bat` instead of `batcat`
- Fixed duplicate alias: `kl` was defined twice (line 57 and 62)
  - Renamed second occurrence to `klf` for `kubectl logs -f`

### defaults/zsh/init

- Fixed fzf initialization for macOS
- Replaced Linux-specific paths (`/usr/share/fzf/`) with cross-platform solution
- Now uses `source <(fzf --zsh)` which works on fzf 0.48+

### defaults/zsh/shell

- Renamed `forma_PATH` → `MACDOTS_PATH` (was a leftover from another project)

---

## 2. Wired Up Orphaned Scripts

Connected scripts that existed but were never called during installation:

### defaults/macos.sh

- Added to `install.sh` to apply macOS system defaults (Finder settings, etc.)

### defaults/apps.sh

- Added to `install.sh` to deploy application configs (nvim setup)

### install/keyboard/karabiner.sh

- Fixed config path from `configs/karabiner/` → `defaults/karabiner/` (actual location)
- Moved from `install/keyboard/` → `install/desktop/` so it's automatically picked up by `desktop.sh`

### theme/k9s.sh

- Now called from the new `install/desktop/k9s.sh` installer

---

## 3. New Config Deployers Created

Added installer scripts for configs that had no deployment mechanism:

| Script | Purpose | Config Location |
|--------|---------|-----------------|
| `install/desktop/ghostty.sh` | Deploy Ghostty terminal config | `configs/ghostty/` |
| `install/desktop/k9s.sh` | Deploy K9s config + Catppuccin theme | `configs/k9s/` |
| `install/desktop/zellij.sh` | Deploy Zellij terminal multiplexer config | `configs/zellij/` |
| `install/desktop/sqruff.sh` | Deploy sqruff SQL linter config | `configs/sqruff/` |
| `install/terminal/zsh.sh` | Set up ~/.zshrc to source macdots zsh config | `defaults/zsh/` |

All follow the existing pattern:
1. Check if tool is installed via `command -v`
2. Remove old config with `rm -rf`
3. Copy new config with `cp -R`

---

## 4. Package Management Improvements

### Added to Brewfile

Added missing packages referenced in configs but not installed:

- `starship` - Shell prompt (referenced in `defaults/zsh/init`)
- `btop` - System monitor (has config in `configs/btop/`)
- `zellij` - Terminal multiplexer (has config in `configs/zellij/`)
- `mise` - Language runtime manager (used in zsh init)

### Language Runtime Management with mise

Created `install/langs/00-mise.sh` to manage language runtimes:

- Installs Go globally via `mise use --global go@latest` (needed by `yaml.sh`)
- Installs Python globally via `mise use --global python@latest` (needed by `python.sh`)
- Named `00-mise.sh` so it runs first in alphabetical order before other lang scripts
- This replaces the idea of adding `go` to Homebrew (better to use mise for language runtimes)

---

## 5. Filename Corrections

Fixed typos in config file names:

| Old Name | New Name |
|----------|----------|
| `configs/ghostty/theme/configs/ghocatppuccin-macchiato..conf` | `catppuccin-macchiato.conf` |
| `configs/zellij/themes/catuppccin.kdl` | `catppuccin.kdl` |

---

## 6. Boot Script Fix

### boot.sh

- **Line 19**: Changed default branch from `stable` → `main` to match the repository's actual default branch

---

## 7. Structural Improvements

### Standardized Error Handling

Added `set -euo pipefail` to all scripts that were missing it:

- `install/desktop.sh`
- `install/terminal.sh`
- `install/langs.sh`
- `install/terminal/aws-cli.sh`
- `install/terminal/uv.sh`
- `install/terminal/krew.sh`
- `install/langs/python.sh`
- `install/langs/yaml.sh`

This ensures:
- `set -e`: Exit immediately if any command fails
- `set -u`: Exit if undefined variables are referenced
- `set -o pipefail`: Pipelines fail if any command in the pipe fails

### Idempotency Guards

Added checks to prevent re-running installs unnecessarily:

#### install/terminal/aws-cli.sh

- Now skips if `~/.aws/credentials` already exists
- Prevents overwriting real AWS credentials with template

#### install/terminal/uv.sh

- Added `command -v uv` check to skip if already installed

#### install/terminal/krew.sh

- Added `command -v kubectl-krew` check to skip if already installed

### Configuration Cleanup

#### configs/yazi/theme.toml

- Removed reference to non-existent `Catppuccin-mocha.tmTheme` file
- The theme colors are already defined inline in the TOML file

---

## Impact Summary

### Before

- **8 critical bugs** that would cause install failures or incorrect behavior
- **4 orphaned scripts** that existed but never ran
- **5 configs** with no deployment mechanism
- **4 missing packages** referenced but not installed
- Inconsistent error handling across scripts
- No idempotency protection (could fail on re-runs)

### After

- ✅ All critical bugs fixed
- ✅ All scripts wired up correctly
- ✅ All configs have deployment mechanisms
- ✅ All referenced packages are installed
- ✅ Consistent error handling with `set -euo pipefail`
- ✅ Idempotent installs that can be re-run safely
- ✅ Language runtimes managed via mise instead of Homebrew
- ✅ Proper macOS-specific paths and commands

---

## Files Modified

### Core Install Scripts

- `install.sh` - Fixed homebrew path typo, added macos.sh and apps.sh
- `boot.sh` - Fixed default branch from stable to main

### Bug Fixes

- `defaults/apps.sh` - Fixed backup logic and cp -R flag
- `defaults/zsh/aliases` - Removed Linux aliases, fixed duplicates
- `defaults/zsh/init` - Fixed fzf paths for macOS
- `defaults/zsh/shell` - Renamed forma_PATH to MACDOTS_PATH
- `configs/nvim/lua/config/keymaps.lua` - Fixed <CR> typo

### Karabiner

- `install/desktop/karabiner.sh` (moved from `install/keyboard/`) - Fixed config path

### Error Handling & Idempotency

- `install/desktop.sh` - Added set -euo pipefail
- `install/terminal.sh` - Added set -euo pipefail
- `install/langs.sh` - Added set -euo pipefail
- `install/terminal/aws-cli.sh` - Added error handling + idempotency guard
- `install/terminal/uv.sh` - Added error handling + idempotency guard
- `install/terminal/krew.sh` - Added error handling + idempotency guard
- `install/langs/python.sh` - Added error handling
- `install/langs/yaml.sh` - Added error handling

### Package Management

- `install/homebrew/Brewfile` - Added starship, btop, zellij, mise

### Config Cleanup

- `configs/yazi/theme.toml` - Removed broken tmTheme reference

## Files Created

### Config Deployers

- `install/desktop/ghostty.sh` - Deploy Ghostty config
- `install/desktop/k9s.sh` - Deploy K9s config + theme
- `install/desktop/zellij.sh` - Deploy Zellij config
- `install/desktop/sqruff.sh` - Deploy sqruff config
- `install/terminal/zsh.sh` - Set up zsh config sourcing

### Language Management

- `install/langs/00-mise.sh` - Install and configure mise for Go/Python runtimes

### Documentation

- `docs/improvements.md` - This file

## Files Renamed

- `configs/ghostty/theme/configs/ghocatppuccin-macchiato..conf` → `catppuccin-macchiato.conf`
- `configs/zellij/themes/catuppccin.kdl` → `catppuccin.kdl`
- `install/keyboard/karabiner.sh` → `install/desktop/karabiner.sh` (moved)

---

## Verification

All changes have been verified:

1. ✅ Syntax checked all `.sh` files with `bash -n`
2. ✅ Verified all `source` paths in `install.sh` resolve to existing files
3. ✅ Verified all configs in `configs/*/` have corresponding installers
4. ✅ Verified all tools referenced in `defaults/zsh/init` are in the Brewfile
5. ✅ Confirmed no references to `forma_PATH` remain
6. ✅ Confirmed no Linux-specific aliases (`batcat`, `fdfind`) remain
