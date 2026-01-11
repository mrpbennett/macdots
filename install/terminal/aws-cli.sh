#!/bin/zsh

# Download AWS CLI
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"

# Install AWS CLI without password prompt (requires NOPASSWD in sudoers)
sudo -n installer -pkg AWSCLIV2.pkg -target /

# Remove the .pkg file after installation
rm -f AWSCLIV2.pkg

# Create .aws directory if it doesn't exist
mkdir -p ~/.aws

# Create .aws/credentials file with template
cat > ~/.aws/credentials << 'EOF'
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY

EOF
