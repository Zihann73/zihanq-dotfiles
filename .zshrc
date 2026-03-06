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
