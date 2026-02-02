## ADDED Requirements

### Requirement: Shell script syntax SHALL be valid

All shell installer scripts in the `install/` directory SHALL pass shell syntax validation to ensure they can execute without parser errors.

#### Scenario: Shell script with valid heredoc content

- **WHEN** a shell script contains a heredoc that generates configuration files
- **THEN** the heredoc content SHALL use proper shell quoting syntax
- **AND** the script SHALL pass `sh -n` or `zsh -n` syntax validation

#### Scenario: Variable assignments within heredocs

- **WHEN** a heredoc contains variable assignments with string values
- **THEN** string values SHALL be quoted without unnecessary escape characters
- **AND** the resulting output file SHALL be valid shell syntax

#### Scenario: SSH connection conditional editor configuration

- **WHEN** the shell installer sets EDITOR based on SSH_CONNECTION
- **THEN** `export EDITOR='vim'` syntax SHALL be used (not `\'vim\'`)
- **AND** the generated .zshrc file SHALL execute without errors
