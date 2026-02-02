# Customization Guide

## Editing Configurations

All configurations live in `~/.local/share/macdots/configs/` and are **symlinked** to their system locations. This means:

- Edit files in one place
- Changes are immediately live
- Easy to track changes with git

## Common Customizations

### Shell (Zsh)

Edit shell configuration in `~/.local/share/macdots/configs/zsh/`:

- `aliases` - Add your custom aliases
- `init` - Initialize additional tools
- `rc` - Main configuration entry point
- `shell` - Shell environment variables

After editing, reload with:
```bash
source ~/.zshrc
```

### Neovim

Configuration is in `~/.local/share/macdots/configs/nvim/`:

- `init.lua` - Entry point
- `lua/config/` - Core configuration (keymaps, options, autocmds)
- `lua/plugins/` - Plugin customizations
- `snippets/` - Code snippets

### Zed Editor

Configuration files in `~/.local/share/macdots/configs/zed/`:

- `settings.json` - Editor settings, themes, fonts
- `keymap.json` - Key bindings
- `tasks.json` - Custom tasks
- `snippets/` - Code snippets

### Aerospace (Window Manager)

Main config: `~/.local/share/macdots/configs/aerospace/aerospace.toml`

Edit this file to change:
- Workspace layouts
- Key bindings
- Window behavior

After editing, restart Aerospace for changes to take effect.

### Karabiner-Elements

Configuration in `~/.local/share/macdots/configs/karabiner/karabiner.json`

This defines complex key modifications. Use the Karabiner-Elements GUI for simpler changes.

## Adding New Tools

### To install a new Homebrew package:

1. Edit `~/.local/share/macdots/install/homebrew/Brewfile`
2. Add your package
3. Run:
   ```bash
   macdots install --homebrew --force
   ```

### To add a new configuration:

1. Create config directory in `~/.local/share/macdots/configs/<tool>/`
2. Create installer in `~/.local/share/macdots/install/<category>/<tool>.sh`
3. Use the symlink pattern:
   ```bash
   macdots_symlink "${MACDOTS_ROOT}/configs/<tool>" "${HOME}/.config/<tool>"
   ```

## Removing Tools

To stop managing a tool with macdots:

```bash
# Remove the symlink (preserves the actual config)
macdots_remove_symlink ~/.config/<tool>

# Or manually:
rm ~/.config/<tool>
```

The config remains in `~/.local/share/macdots/backups/` if it was backed up.

## Best Practices

1. **Commit often** - Track your config changes in git
2. **Test changes** - Use `macdots doctor` to verify configs
3. **Backup first** - Run `macdots backup` before major changes
4. **Stay organized** - Keep related configs in their own directories
