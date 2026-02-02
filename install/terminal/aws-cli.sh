#!/bin/zsh
#
# AWS CLI Installer
#

# Source the core library
source "${MACDOTS_ROOT}/lib/core.sh"

if ! command -v aws >/dev/null 2>&1; then
    macdots_step "Installing AWS CLI..."
    
    # Download AWS CLI
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "/tmp/AWSCLIV2.pkg"
    
    # Install AWS CLI
    sudo installer -pkg /tmp/AWSCLIV2.pkg -target /
    
    # Remove the .pkg file after installation
    rm -f /tmp/AWSCLIV2.pkg
    
    macdots_success "AWS CLI installed"
else
    macdots_info "AWS CLI is already installed"
fi

# Create .aws directory if it doesn't exist
if [[ ! -d ~/.aws ]]; then
    macdots_step "Creating AWS configuration directory..."
    mkdir -p ~/.aws
    
    # Create .aws/credentials file with template
    cat > ~/.aws/credentials << 'EOF'
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY

EOF
    
    macdots_info "AWS credentials template created at ~/.aws/credentials"
fi
