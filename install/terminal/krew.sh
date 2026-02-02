#!/bin/zsh
#
# Krew (kubectl plugin manager) Installer
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if command -v kubectl >/dev/null 2>&1; then
    if ! command -v kubectl-krew >/dev/null 2>&1; then
        macdots_step "Installing Krew..."
        (
            set -x; cd "$(mktemp -d)" &&
            OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
            ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
            KREW="krew-${OS}_${ARCH}" &&
            curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
            tar zxvf "${KREW}.tar.gz" &&
            ./"${KREW}" install krew
        )
        macdots_success "Krew installed"
    else
        macdots_info "Krew is already installed"
    fi
else
    macdots_warn "kubectl not found, skipping Krew installation"
fi
