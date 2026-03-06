# Hannah's Dotfiles

> *"The environment you work in determines the quality of the work you produce."*

**Modern & Minimalist Dotfiles for macOS**

A high-performance development environment optimized for productivity and AI workflow. Built with **Antidote** for blazing-fast Zsh plugin management and **Starship** for a cross-shell, context-aware prompt.

**Key Features:**

- :rocket: **Zero-lag Startup** — Optimized plugin loading with Antidote
- :art: **Context-aware UI** — Aesthetic and functional prompt via Starship
- :bust_in_silhouette: **Identity Isolation** — Automatic Git identity switching for personal and work projects
- :lock: **Robust Connectivity** — Hardened SSH config using Port 443 to bypass restrictive networks/VPNs

## Quick Start

```bash
git clone git@github.com:Zihann73/zihanq-dotfiles.git ~/dotfiles && cd ~/dotfiles && bash install.sh
```

## What's Inside

| File | Purpose |
| --- | --- |
| `install.sh` | One-command symlink setup & environment bootstrap |
| `.zshrc` | Zsh config — aliases, env vars, plugin loading |
| `.zsh_plugins.txt` | Antidote plugin manifest |
| `.gitconfig` | Git global config — identity, aliases, conditional includes |
| `.gitconfig-work` | Work identity template (auto-loaded for `~/Documents/Work/`) |
| `starship.toml` | Starship prompt theme |
| `ssh_config` | SSH over Port 443 for GitHub (VPN/firewall bypass) |

## Fresh Mac Setup

### Phase 1 — Base Environment

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Core tools
brew install antidote starship git zoxide fzf
brew install --cask font-jetbrains-mono-nerd-font
```

> **iTerm2 font**: `Settings` → `Profiles` → `Text` → `Font` → `JetBrainsMono Nerd Font`

### Phase 2 — SSH & Repository

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
pbcopy < ~/.ssh/id_ed25519.pub
```

Add the copied public key to **GitHub** → **Settings** → **SSH Keys**, then:

```bash
git clone git@github.com:Zihann73/zihanq-dotfiles.git ~/dotfiles
```

### Phase 3 — Deploy

```bash
cd ~/dotfiles
bash install.sh
mkdir -p ~/Documents/Work
source ~/.zshrc
```

Done. Ready to build.

## Git Aliases

| Alias | Command |
| --- | --- |
| `gs` | `git status` |
| `ga` | `git add` |
| `gaa` | `git add --all` |
| `gc "msg"` | `git commit -m "msg"` |
| `gp` | `git push` |
| `gl` | `git pull` |
| `gcb name` | `git checkout -b name` |

## Git Identity Switching

Commits automatically use different identities based on project location:

- **Default** — Personal email from `.gitconfig`
- **`~/Documents/Work/`** — Work email from `.gitconfig-work`

Edit `.gitconfig-work` to set your work email. No manual switching needed.

## Daily Workflow

```bash
cd ~/dotfiles

# Push config changes
gaa && gc "update config" && gp

# Sync on another machine
gl
```

## Troubleshooting

| Problem | Solution |
| --- | --- |
| Git push fails behind VPN/firewall | `ssh_config` routes GitHub over Port 443 |
| Terminal shows garbled icons | Install `JetBrainsMono Nerd Font` and set it in iTerm2 |
| Zsh plugin conflicts | Antidote manages all plugins declaratively via `.zsh_plugins.txt` |
