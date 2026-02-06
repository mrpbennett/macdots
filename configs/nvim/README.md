# Neovim Configuration

A comprehensive Neovim setup powered by [LazyVim](https://lazyvim.github.io/), customized for full-stack development with Kubernetes, Python, Go, and database workflows.

## Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Plugins](#plugins)
- [Keybindings](#keybindings)
- [Language Support](#language-support)
- [Snippets](#snippets)
- [Kubernetes Integration](#kubernetes-integration)
- [Database Integration](#database-integration)
- [Customization](#customization)

---

## Overview

This configuration extends LazyVim with:

- **Modern completion** using blink.cmp with LSP and snippet support
- **Kubernetes-native development** with schema validation and K9s integration
- **Database management** via Dadbod with a pre-configured PostgreSQL connection
- **Clean UI** featuring Catppuccin theme, minimal lualine, and snacks.picker

---

## Prerequisites

| Tool        | Purpose              | Required                                                 |
| ----------- | -------------------- | -------------------------------------------------------- |
| Neovim 0.9+ | Editor               | Yes                                                      |
| Git         | Plugin manager       | Yes                                                      |
| ripgrep     | Search functionality | Yes                                                      |
| fd          | File finding         | Yes                                                      |
| k9s         | Kubernetes CLI       | Optional                                                 |
| kubectl     | Kubernetes access    | Optional                                                 |
| yamlfmt     | YAML formatting      | Optional (`go install github.com/google/yamlfmt@latest`) |

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                 # Entry point - bootstraps lazy.nvim
├── .lazy.lua                # Lazy config + database setup
├── lazyvim.json            # LazyVim extras configuration
├── lazy-lock.json          # Pinned plugin versions
├── stylua.toml             # Lua formatter config
├── .neoconf.json           # Neodev/Neoconf settings
├── .gitignore             # Git ignore rules
├── snippets/               # LuaSnip snippets
│   ├── kubernetes.json    # K8s resource snippets
│   ├── python.json
│   ├── javascript.json
│   ├── dockerfile.json
│   └── package.json
└── lua/
    ├── config/
    │   ├── lazy.lua       # Plugin manager setup
    │   ├── options.lua    # Editor options
    │   ├── keymaps.lua    # Custom keybindings
    │   └── autocmds.lua   # Autocommands
    └── plugins/
        ├── colorschema.lua    # Catppuccin theme
        ├── kubernetes.lua     # K8s YAML schemas
        └── tweaks/            # Plugin customizations
            ├── blink.lua      # Completion config
            ├── conform.lua    # Formatter overrides
            ├── lualine.lua    # Status line style
            ├── noice.lua      # Cmdline UI
            └── snacks.lua     # Picker settings
```

---

## Plugins

### Core Framework

| Plugin                                          | Description        |
| ----------------------------------------------- | ------------------ |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager     |
| [LazyVim](https://github.com/LazyVim/LazyVim)   | Base configuration |

### Editor Enhancement

| Plugin                                                       | Description                |
| ------------------------------------------------------------ | -------------------------- |
| [blink.cmp](https://github.com/saghen/blink.cmp)             | Modern completion engine   |
| [conform.nvim](https://github.com/stevearc/conform.nvim)     | Formatter with yamlfmt     |
| [snacks.nvim](https://github.com/folke/snacks.nvim)          | Picker, terminal, explorer |
| [noice.nvim](https://github.com/folke/noice.nvim)            | Command line UI            |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line                |
| [which-key.nvim](https://github.com/folke/which-key.nvim)    | Keybinding hints           |

### Version Control & Editor

| Plugin                                                    | Description      |
| --------------------------------------------------------- | ---------------- |
| [gitsigns.nvim](https://github.com/stevearc/conform.nvim) | Git decorations  |
| [mini.diff](https://github.com/echasnovski/mini.diff)     | Diff view        |
| [flash.nvim](https://github.com/folke/flash.nvim)         | Motion/search    |
| [trouble.nvim](https://github.com/folke/trouble.nvim)     | Diagnostics list |

### Language Support

| Plugin                                                                | Description         |
| --------------------------------------------------------------------- | ------------------- |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)            | LSP configurations  |
| [mason.nvim](https://github.com/williamboman/mason.nvim)              | LSP server manager  |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint)                | Linter support      |
| [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim)           | JSON/YAML schemas   |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |

### AI & Automation

| Plugin                                              | Description       |
| --------------------------------------------------- | ----------------- |
| [sidekick.nvim](https://github.com/LazyVim/LazyVim) | AI assistant      |
| [yanky.nvim](https://github.com/gbprod/yanky.nvim)  | Improved yank/put |

### Database & Kubernetes

| Plugin                                                                           | Description        |
| -------------------------------------------------------------------------------- | ------------------ |
| [vim-dadbod](https://github.com/tpope/vim-dadbod)                                | Database interface |
| [vim-dadbod-ui](https://github.com/kristijanhusak/vim-dadbod-ui)                 | TUI for Dadbod     |
| [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion) | DB completion      |
| [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim)        | Python venv picker |

### Utilities

| Plugin                                                                             | Description             |
| ---------------------------------------------------------------------------------- | ----------------------- |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim)                  | TODO highlighting       |
| [grug-far.nvim](https://github.com/LazyVim/grug-far.nvim)                          | Advanced search/replace |
| [persistence.nvim](https://github.com/folke/persistence.nvim)                      | Session management      |
| [render-markdown.nvim](https://github.com/meanderingstranger/render-markdown.nvim) | Markdown rendering      |
| [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)           | Markdown preview        |

---

## Keybindings

### Insert Mode

| Binding | Action                  |
| ------- | ----------------------- |
| `jj`    | Escape to Normal mode   |
| `jk`    | Escape to Normal mode   |
| `<A-j>` | Move current line down  |
| `<A-k>` | Move current line up    |
| `<CR>`  | Auto-indent and newline |

### Normal Mode

| Binding      | Action                               |
| ------------ | ------------------------------------ |
| `aa`         | Append (go to end of line in insert) |
| `<A-j>`      | Move current line down               |
| `<A-k>`      | Move current line up                 |
| `<leader>k9` | Open K9s (if installed)              |

### Visual Mode

| Binding | Action              |
| ------- | ------------------- |
| `<A-j>` | Move selection down |
| `<A-k>` | Move selection up   |

### LazyVim Defaults

| Binding      | Action                 |
| ------------ | ---------------------- |
| `<leader>`   | Show which-key popup   |
| `<leader>f`  | Find files (picker)    |
| `<leader>s`  | Search (live grep)     |
| `<leader>sg` | Grep current word      |
| `<leader>gb` | Git branches           |
| `<leader>gc` | Git commits            |
| `<leader>td` | Toggle diagnostics     |
| `<leader>tt` | Toggle Trouble         |
| `<leader>tp` | Toggle picker explorer |
| `<leader>wq` | Save and quit          |

---

## Language Support

### Python

- **LSP**: Pyright
- **Formatter**: ruff
- **Linter**: ruff
- **venv**: `venv-selector.nvim` (toggle with `<leader>cv`)

### Go

- **LSP**: gopls (via LazyVim extras)
- **Formatter**: gofmt/gofumpt

### YAML (Kubernetes)

- **LSP**: yamlls with Kubernetes schemas
- **Formatter**: yamlfmt
- **Schemas**: K8s, GitHub Actions, Docker Compose, Argo Workflows, and more

### Markdown

- **LSP**: marksman
- **Preview**: markdown-preview.nvim (`:MarkdownPreview`)
- **Rendering**: render-markdown.nvim

### SQL

- **LSP**: sqlls
- **Client**: vim-dadbod

---

## Snippets

Custom snippets are located in `~/.config/nvim/snippets/` and include:

### Kubernetes Snippets

| Prefix            | Description           |
| ----------------- | --------------------- |
| `k8s-deployment`  | Deployment manifest   |
| `k8s-service`     | Service manifest      |
| `k8s-configmap`   | ConfigMap manifest    |
| `k8s-secret`      | Secret manifest       |
| `k8s-ingress`     | Ingress manifest      |
| `k8s-statefulset` | StatefulSet manifest  |
| `k8s-pvc`         | PersistentVolumeClaim |
| `k8s-job`         | Job manifest          |
| `k8s-cronjob`     | CronJob manifest      |

### Other Snippets

| File              | Prefixes                              |
| ----------------- | ------------------------------------- |
| `python.json`     | Python class, function, if/try blocks |
| `javascript.json` | ES6+, React snippets                  |
| `dockerfile.json` | Multi-stage builds                    |
| `package.json`    | Common scripts                        |

---

## Kubernetes Integration

### K9s Integration

If K9s is installed, access it with:

```
<leader>k9
```

### YAML Schema Configuration

Kubernetes YAML files automatically get:

- Schema validation
- Schema-aware completion
- Hover documentation
- Format on save

### Pre-configured Schemas

```lua
-- From lua/plugins/kubernetes.lua
kubernetes://*.yaml
http://json.schemastore.org/github-workflow
http://json.schemastore.org/github-action
http://json.schemastore.org/chart
https://json.schemastore.org/dependabot-v2
https://json.schemastore.org/gitlab-ci
https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json
https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json
```

---

## Database Integration

### Pre-configured Connection

Via a `~/.config/nvim/.lazy.lua` config, see [lazyvim.org/extras/lang/sql](https://www.lazyvim.org/extras/lang/sql)

### Usage

| Command      | Action                       |
| ------------ | ---------------------------- |
| `:DB`        | Open Dadbod UI               |
| `:DB <name>` | Connect to specific database |
| `:DBS`       | List available connections   |

---

## Customization

### Adding New Plugins

Create a new file in `lua/plugins/` or `lua/plugins/tweaks/`:

```lua
-- lua/plugins/myplugin.lua
return {
  "author/myplugin",
  opts = {}, -- plugin configuration
  config = function() end, -- setup function
}
```

### Modifying Keybindings

Edit `~/.config/nvim/lua/config/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>my", function()
  -- Your custom action
end, { desc = "My custom keybinding" })
```

### Changing Colorscheme

Edit `lua/plugins/colorschema.lua` and change the `colorscheme` option.

### Formatter Configuration

Modify `lua/plugins/tweaks/conform.lua` to add or change formatters:

```lua
formatters_by_ft = {
  yaml = { "yamlfmt" },
  json = { "jq" },
}
```

### Lua Formatting

Edit `stylua.toml` to adjust formatting rules:

```toml
indent_type = "Spaces"
indent_width = 2
column_width = 120
```

---

## Commands Reference

| Command        | Description                      |
| -------------- | -------------------------------- |
| `:Lazy`        | Open Lazy package manager        |
| `:Mason`       | Manage LSPs, linters, formatters |
| `:Checkhealth` | Check Neovim health              |
| `:Lazy sync`   | Update all plugins               |
| `:Format`      | Format current buffer            |
| `:DBUI`        | Open database UI                 |
| `:Sidekick`    | Open AI assistant                |

---

## Troubleshooting

### Plugin Issues

```bash
# Rebuild plugins
:Lazy clean
:Lazy sync

# Check health
:Checkhealth
```

### LSP Issues

```bash
# Restart LSP
:LspStart
:LspStop
:LspInfo
```

### Clear Cache

```bash
# Clear Lazy cache
:Lazy load
```

---

## Credits

- [LazyVim](https://lazyvim.github.io/) - Base configuration
- [LazyVim Extras](https://lazyvim.github.io/extras) - Language support
- [Catppuccin](https://github.com/catppuccin/nvim) - Theme
