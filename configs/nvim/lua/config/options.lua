-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- 🔧 Global indentation settings (4 spaces)
-- vim.opt.smartindent = true
-- vim.opt.autoindent = true

vim.opt.expandtab = true -- Use spaces instead of tabs
vim.o.timeoutlen = 300   -- time (ms) to wait for mapped sequence to complete

-- no comments on new lines
vim.opt.formatoptions:remove("c") -- Don't auto-comment new lines

-- JavaScript/TypeScript formatting
vim.g.lazyvim_eslint_auto_format = true
vim.g.lazyvim_prettier_needs_config = false

-- 🐍 PYTHON
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

-- turn off swap
vim.opt.swapfile = false

-- ⏭️ skip copilot suggestions in blink.
vim.g.ai_cmp = false
