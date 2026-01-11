# macdots

Currently a Work In Progress...

macdots is a lightweight collection of macOS dotfiles, application configurations, and install scripts designed to bootstrap a consistent developer environment. It focuses on terminal tools, editors (Neovim, Zed), terminal themes, and a small install orchestration to get a macOS machine into a preferred state quickly.

This README explains what is in the repository, the supported workflow for installing and updating, how to customize configurations, and where to look when things go wrong.

---

## Overview

- Purpose: Provide a reusable, opinionated set of configuration files and install helpers for macOS.
- Scope: Terminal tools, editor configs (Neovim, Zed), terminal themes, keyboard tweaks, and install helper scripts.
- Intended platform: macOS (the install scripts validate macOS and will exit otherwise).

---

## Quick start

There are two main entrypoints in this repository:

- `boot.sh` — clones/installs the repository into `~/.local/share/macdots` and starts the installation.
- `install.sh` — orchestrates the installation steps once the repo is placed in `~/.local/share/macdots`.

To bootstrap on a fresh macOS machine you can run the following sequence locally (example):

```/dev/null/USAGE.md#L1-6
# Clone the repo and run the bootstrap script (example)
git clone https://github.com/mrpbennett/macdots.git ~/macdots
cd ~/macdots
./boot.sh
```

Alternatively, if you already have `macdots` under `~/.local/share/macdots` you can source the installer directly:

```macdots/install.sh#L1-200
# Example: run the install orchestration from the cloned location
source ~/.local/share/macdots/install.sh
```

Notes:
- `boot.sh` expects to run on macOS and will clone into `~/.local/share/macdots`. It also supports checking out a non-default ref via the `macdots_REF` environment variable.
- `install.sh` sources several platform-specific helper scripts (Homebrew, terminal, desktop, keyboard). Those helper scripts are expected to live under the `install/` subtree inside `~/.local/share/macdots`.

---

## Repository layout

Top-level files:
- `boot.sh` — bootstrapper that clones the repository and kicks off installation.
- `install.sh` — main orchestration file that runs installation steps.

Top-level directories:
- `configs/` — application configuration files and themes
  - `configs/nvim/` — full Neovim configuration (LazyVim-style plugins, Lua config, snippets).
  - `configs/zed/` — Zed editor settings, keymaps, snippets, themes.
  - `configs/ghostty/` — terminal theme configs for Ghostty.
  - `configs/k9s/` — k9s config and alias files.
  - `configs/yazi/` — Yazi configuration.
  - `configs/aerospace/` — custom Aerospace theme/TOML.
  - `configs/zsh` — zsh related config (top-level file).
- `install/` — (expected) helper install scripts for Homebrew, terminal tooling, desktop utilities, keyboard customizations (these are sourced by `install.sh` if present).

Examples of important paths:
- `macdots/boot.sh` — entrypoint used to clone and run the installer.
- `macdots/install.sh` — installer orchestration.
- `macdots/configs/nvim/` — Neovim config (plugins, lua, snippets).
- `macdots/configs/zed/` — Zed editor settings and tasks.

---

## What this repo configures

Out of the box, the repository is designed to:
- Install Homebrew and macOS packages (if `install/homebrew/homebrew.sh` is provided).
- Provision terminal utilities and tweaks (if `install/terminal.sh` is provided).
- Configure desktop utilities and macOS-specific settings (if `install/desktop.sh` is provided).
- Apply keyboard tweaks (if `install/keyboard/macos-keyboard.sh` is present).
- Drop application configs into place for Neovim, Zed, Ghostty, K9s, Yazi, etc., by copying or symlinking files from `configs/`.

The installer is defensive: it checks for the expected `~/.local/share/macdots` location and warns/skips steps when helper scripts are missing.

---

## Customization

- Edit files under `configs/` to adjust application configuration.
  - For Neovim: modify `configs/nvim/init.lua` and Lua modules under `configs/nvim/lua/`.
  - For Zed: update `configs/zed/settings.json` or `configs/zed/keymap.json`.
  - For terminal themes: check `configs/ghostty/theme/`.
- If you want to add packages or change install steps, add or update scripts under `install/`:
  - `install/homebrew/homebrew.sh` — install Homebrew and package lists.
  - `install/terminal.sh` — terminal tooling and shell environment setup.
  - `install/desktop.sh` — GUI apps and macOS defaults.
  - `install/keyboard/macos-keyboard.sh` — keyboard shortcuts and mappings.

When you modify `configs/` or `install/`, you can re-run the relevant installation scripts or manually copy/symlink the files into your home directory.

---

## Updating

If you originally used `boot.sh` to clone into `~/.local/share/macdots`, update by pulling the upstream repo:

```/dev/null/GIT_UPDATE.md#L1-3
cd ~/.local/share/macdots
git fetch origin
git pull --ff-only
# Optionally re-run the installer:
source ~/.local/share/macdots/install.sh
```

`boot.sh` also supports checking out a different branch or tag by setting `macdots_REF` before running it.

---

## Troubleshooting

- "This script is designed for macOS only": The install scripts validate `uname` and will exit on non-Darwin platforms.
- Missing `~/.local/share/macdots`: `install.sh` expects the repository to exist at `~/.local/share/macdots`; use `boot.sh` to create that location or clone manually.
- Missing helper installer files (Homebrew, terminal, desktop): `install.sh` will warn and skip steps if the helper scripts are not present under `install/`.
- If an install step fails, re-run the failing script with verbose output or check the script for the failing command.

Useful files to inspect when debugging:
- `macdots/boot.sh` — bootstrap behavior and clone logic
- `macdots/install.sh` — orchestration and conditional sourcing of helper scripts
- config files under `macdots/configs/` for app-specific issues.

---

## Security

- Scripts in this repository may install packages and change system settings. Review `install/` scripts and configuration files before running them on a machine you care about.
- `boot.sh` clones from `https://github.com/mrpbennett/macdots.git`. If you modify the origin or run from a fork, ensure you trust the source.

