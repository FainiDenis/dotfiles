#!/bin/sh

echo "Setting up your Mac..."

# Check if Xcode Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed."
fi

# Define the dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Check if .dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Cloning dotfiles repository..."
  mkdir -p "$DOTFILES_DIR"
  git clone --recursive https://github.com/FainiDenis/dotfiles.git "$DOTFILES_DIR"
else
  echo ".dotfiles directory already exists."
fi

# Change to dotfiles directory
cd "$DOTFILES_DIR" || exit 1

# Check for Oh My Zsh and install if we don't have it
if ! command -v omz &> /dev/null; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Remove existing .zshrc and create symlink
rm -rf "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Update Homebrew recipes
brew update

# Install all dependencies with bundle
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
  brew bundle --file="$DOTFILES_DIR/Brewfile"
else
  echo "Warning: Brewfile not found"
fi

# Create project directories
mkdir -p "$HOME/Documents/Projects/resume"

# Clone Github repositories
if [ -f "$DOTFILES_DIR/clone.sh" ]; then
  chmod +x "$DOTFILES_DIR/clone.sh"
  "$DOTFILES_DIR/clone.sh"
fi

# Symlink the Mackup config file
ln -sf "$DOTFILES_DIR/.mackup.cfg" "$HOME/.mackup.cfg"

# Set macOS preferences
if [ -f "$DOTFILES_DIR/.macos" ]; then
  chmod +x "$DOTFILES_DIR/.macos"
  source "$DOTFILES_DIR/.macos"
fi

echo "Setup complete! Please restart your terminal."