# Dotfiles Repository Guide

A systematic guide for maintaining and deploying this dotfiles repo. Designed as a portable "digital asset" — no matter how many Macs you switch, you can be up and running in minutes.

---

## 1. Repository Structure

| File | Purpose |
| --- | --- |
| `install.sh` | **Core**: One-command symlink setup and environment bootstrap |
| `.zshrc` | Zsh configuration (aliases, environment variables, plugin loading) |
| `.zsh_plugins.txt` | Antidote plugin manifest |
| `.gitconfig` | Git global config (primary identity + aliases + conditional includes) |
| `.gitconfig-work` | Work identity template (auto-loaded for work projects) |
| `starship.toml` | Starship prompt theme |
| `ssh_config` | SSH config optimized for Port 443 (bypasses VPN/firewall blocks) |
| `README.md` | Quick-start reference |

---

## 2. Configuration Files Explained

### install.sh — Bootstrap Script

Creates required directories and symlinks all config files to their expected locations:

```bash
#!/bin/bash

DOTFILES_DIR=$(pwd)

echo "🚀 Initializing environment..."

mkdir -p ~/.config ~/.ssh

ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
ln -sf "$DOTFILES_DIR/.zsh_plugins.txt" ~/.zsh_plugins.txt
ln -sf "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES_DIR/.gitconfig-work" ~/.gitconfig-work
ln -sf "$DOTFILES_DIR/starship.toml" ~/.config/starship.toml
ln -sf "$DOTFILES_DIR/ssh_config" ~/.ssh/config

echo "✅ Symlinks created."
echo "👉 Run 'source ~/.zshrc' to activate."
```

### .zshrc — Shell Configuration

Loads Homebrew, initializes Antidote for plugin management, defines common aliases, and starts the Starship prompt:

```bash
# Load Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Load Antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

# Aliases
alias ll='ls -lahG'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gcb='git checkout -b'

# Starship prompt (must be last)
eval "$(starship init zsh)"
```

### .gitconfig — Git Identity Isolation

Sets the default (personal) identity and automatically switches to a work identity for projects under `~/Documents/Work/`:

```ini
[user]
    name = Zihann73
    email = your.personal@email.com
[init]
    defaultBranch = main
[color]
    ui = true
[alias]
    st = status
    cm = commit -m
    lg = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all

# Auto-switch to work identity for ~/Documents/Work/ projects
[includeIf "gitdir:~/Documents/Work/"]
    path = ~/.gitconfig-work
```

---

## 3. New Machine Onboarding

Follow these steps in order. Total time: ~5-10 minutes.

### Phase 1 — Base Environment

**1. Install Homebrew:**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**2. Install core tools:**

```bash
brew install antidote starship git zoxide fzf
brew install --cask font-jetbrains-mono-nerd-font
```

**3. Configure iTerm2 font:**

`Settings` → `Profiles` → `Text` → `Font` → select `JetBrainsMono Nerd Font`

### Phase 2 — SSH & Repository

**1. Generate and configure SSH key:**

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub
```

Go to **GitHub** → **Settings** → **SSH and GPG Keys** → **New SSH Key** and paste.

**2. Clone this repository:**

```bash
git clone git@github.com:Zihann73/zihanq-dotfiles.git ~/dotfiles
```

### Phase 3 — Deploy

**1. Run the install script:**

```bash
cd ~/dotfiles
bash install.sh
```

**2. Create work directory:**

```bash
mkdir -p ~/Documents/Work
```

**3. Activate:**

```bash
source ~/.zshrc
```

Done. Your environment is ready.

---

## 4. Day-to-Day Maintenance

### Updating configs

Edit files inside `~/dotfiles`, then push:

```bash
cd ~/dotfiles
gaa && gc "update config" && gp
```

### Syncing to another machine

```bash
cd ~/dotfiles
gl
```

### Work identity

Any project cloned inside `~/Documents/Work/` will automatically use the email from `.gitconfig-work`. Edit that file to set your work email — no manual switching needed.

---

## 5. Problems This Setup Solves

| Problem | How it's handled |
| --- | --- |
| Git push fails behind VPN/firewall | `ssh_config` routes GitHub connections over Port 443 |
| Terminal shows garbled characters | JetBrainsMono Nerd Font provides full icon/glyph support |
| Plugin conflicts or slow shell startup | Antidote manages plugins declaratively with optimized loading |
| Accidentally committing with wrong email | `includeIf` in `.gitconfig` auto-switches identity by directory |
