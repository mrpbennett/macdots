## 1. Fix syntax error in install/shell.sh

- [x] 1.1 Remove backslash escapes from line 61: change `export EDITOR=\'vim\'` to `export EDITOR='vim'`
- [x] 1.2 Remove backslash escapes from line 63: change `export EDITOR=\'nvim\'` to `export EDITOR='nvim'`

## 2. Verify

- [x] 2.1 Run `zsh -n install/shell.sh` to verify syntax is valid
- [x] 2.2 Confirm no other syntax errors exist in the file
