#!/bin/zsh

set -euo pipefail

# install yamlfmt for formatting yaml
go install github.com/google/yamlfmt/cmd/yamlfmt@latest
