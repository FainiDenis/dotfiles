#!/bin/sh

echo "Generating a new SSH key for GitHub..."

if [ -z "$1" ]; then
    echo "Usage: $0 <your-email@example.com>"
    exit 1
fi

# Generate SSH key
ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/id_ed25519

# Start ssh-agent
eval "$(ssh-agent -s)"

# Create SSH config if it doesn't exist
touch ~/.ssh/config
echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config

# Add key to ssh-agent (removed deprecated -K flag)
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

echo "SSH key generated successfully!"
echo "Run 'pbcopy < ~/.ssh/id_ed25519.pub' and paste the key into GitHub"