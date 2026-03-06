# Zihann73's Dotfiles

> *"The environment you work in determines the quality of the work you produce."*

**Modern & Minimalist Dotfiles for macOS**

A high-performance development environment optimized for productivity and AI workflow. Built with **Antidote** for blazing-fast Zsh plugin management and **Starship** for a cross-shell, context-aware prompt.

**Key Features:**

- :rocket: **Zero-lag Startup** — Optimized plugin loading with Antidote
- :art: **Context-aware UI** — Aesthetic and functional prompt via Starship
- :bust_in_silhouette: **Identity Isolation** — Automatic Git identity switching for personal and work projects
- :lock: **Robust Connectivity** — Hardened SSH config using Port 443 to bypass restrictive networks/VPNs

---

## Get Started

> **First time here?** Follow these 3 steps. Takes about 5-10 minutes on a fresh Mac.
>
> For a deeper walkthrough of every config file, see **[GUIDE.md](GUIDE.md)**.

### Step 1 — Install prerequisites

```bash
# Install Homebrew (skip if already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core tools
brew install antidote starship git zoxide fzf
brew install --cask font-jetbrains-mono-nerd-font
```

Then set your terminal font: **iTerm2** → `Settings` → `Profiles` → `Text` → `Font` → `JetBrainsMono Nerd Font`

### Step 2 — Set up SSH and clone

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Copy public key to clipboard
pbcopy < ~/.ssh/id_ed25519.pub
```

Paste the key into **GitHub** → **Settings** → **SSH and GPG Keys** → **New SSH Key**. Then clone:

```bash
git clone git@github.com:Zihann73/zihanq-dotfiles.git ~/dotfiles
```

### Step 3 — Deploy

**Option A: Fresh Mac (no existing configs)**

```bash
cd ~/dotfiles
bash install.sh
mkdir -p ~/Documents/Work
source ~/.zshrc
```

**Option B: Already have your own `.zshrc` / `.gitconfig` / etc.**

> `install.sh` will **automatically back up** your existing files to `~/.dotfiles_backup/` before overwriting. But if you'd rather keep your current setup and just pick what you need, do it manually:

```bash
cd ~/dotfiles

# Read each file, copy the parts you want into your own configs.
# For example, append the aliases to your existing .zshrc:
cat .zshrc            # review, then copy what you need

# Or just grab the SSH fix:
cat ssh_config        # copy into your ~/.ssh/config

# Or just grab the Starship theme:
cp starship.toml ~/.config/starship.toml
```

Pick **Option A** if you're starting fresh. Pick **Option B** if you already have configs you don't want to lose.

---

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

## Learn More

See **[GUIDE.md](GUIDE.md)** for a detailed explanation of every configuration file and the design decisions behind this setup.
