#!/bin/bash

DOTFILES_DIR=$(pwd)

echo "🚀 Initializing environment..."

# Create required directories
mkdir -p ~/.config ~/.ssh

# Create symlinks (force overwrite)
ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zsh_plugins.txt" ~/.zsh_plugins.txt
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitconfig-work" ~/.gitconfig-work
ln -sf "$DOTFILES_DIR/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/ssh_config" ~/.ssh/config

echo "✅ Symlinks created."
echo "👉 Run 'source ~/.zshrc' to activate."
