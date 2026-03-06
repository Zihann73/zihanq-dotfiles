#!/bin/bash

DOTFILES_DIR=$(pwd)
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "🚀 Initializing environment..."

# Create required directories
mkdir -p ~/.config ~/.ssh

# Files to symlink: source -> target
declare -A FILES=(
    [".zshrc"]="$HOME/.zshrc"
    [".zsh_plugins.txt"]="$HOME/.zsh_plugins.txt"
    [".gitconfig"]="$HOME/.gitconfig"
    [".gitconfig-work"]="$HOME/.gitconfig-work"
    ["starship.toml"]="$HOME/.config/starship.toml"
    ["ssh_config"]="$HOME/.ssh/config"
)

# Back up existing files before overwriting
BACKED_UP=false
for src in "${!FILES[@]}"; do
    target="${FILES[$src]}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        if [ "$BACKED_UP" = false ]; then
            mkdir -p "$BACKUP_DIR"
            echo "📦 Backing up existing configs to $BACKUP_DIR"
            BACKED_UP=true
        fi
        cp "$target" "$BACKUP_DIR/"
        echo "   backed up: $target"
    fi
done

# Create symlinks
for src in "${!FILES[@]}"; do
    target="${FILES[$src]}"
    ln -sf "$DOTFILES_DIR/$src" "$target"
done

echo ""
echo "✅ Symlinks created."
if [ "$BACKED_UP" = true ]; then
    echo "📦 Your original configs are saved in: $BACKUP_DIR"
    echo "   To restore: cp $BACKUP_DIR/.zshrc ~/.zshrc  (etc.)"
fi
echo ""
echo "👉 Run 'source ~/.zshrc' to activate."
echo ""
echo "⚠️  If you had custom configs, you may want to merge instead of overwrite."
echo "   Compare your backup with the new files and copy over what you need."
