## Why

The shell installer script (`install/shell.sh`) contains a syntax error that prevents it from executing successfully. Lines 61 and 63 have incorrectly escaped single quotes (`\'vim\'` and `\'nvim\'`) within a heredoc that generates the user's `.zshrc` file. This causes shell parsing failures when the script runs.

## What Changes

- Fix quote escaping in the SSH_CONNECTION conditional block within the ZSHRC_CONTENT heredoc
- Remove unnecessary backslash escapes from EDITOR variable assignments
- Ensure the generated .zshrc file has valid shell syntax

## Capabilities

### New Capabilities
- `shell-installer-syntax-validation`: Shell installer scripts must have valid syntax and pass shell parser checks

### Modified Capabilities
<!-- No existing capabilities are being modified -->

## Impact

- `install/shell.sh`: Fix lines 61 and 63 to use proper quote syntax
- Users will be able to run the shell installer without syntax errors
- Generated `.zshrc` files will be syntactically valid
