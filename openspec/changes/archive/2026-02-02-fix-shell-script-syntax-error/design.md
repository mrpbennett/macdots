## Context

The shell installer (`install/shell.sh`) generates a `.zshrc` file using a heredoc pattern. Within this heredoc, there's an if/else block that sets the EDITOR variable based on whether the user is in an SSH session. The current implementation incorrectly escapes single quotes with backslashes.

## Goals / Non-Goals

**Goals:**
- Fix the syntax error in the heredoc content
- Ensure the script passes shell syntax validation
- Make the generated .zshrc file valid

**Non-Goals:**
- Refactoring the entire shell installer
- Changing the logic of editor selection
- Adding additional shell configuration options

## Decisions

### Decision 1: Remove backslash escapes from quotes

**Approach:** Change `\'vim\'` to `'vim'` and `\'nvim\'` to `'nvim'` on lines 61 and 63.

**Rationale:** Within a single-quoted heredoc (ZSHRC_CONTENT='...'), the content is treated literally. When that content is later written to .zshrc and executed, plain single quotes around string values are the correct syntax. The backslash escapes were unnecessary and cause parsing errors.

**Alternative considered:** Using double quotes (`"vim"`) would also work, but single quotes are more conventional for literal strings in shell scripts.

### Decision 2: Verify fix with syntax check

After fixing, we'll verify using `zsh -n install/shell.sh` to ensure no other syntax issues exist.
