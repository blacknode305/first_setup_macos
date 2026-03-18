#!/usr/bin/env bash
# Fully compatible with Bash 3.2 (macOS default)
# Exit on error
set -e

echo "Starting macOS first_setup.sh..."

# -------------------------------------------------
# Check prerequisites: Git and Homebrew
# -------------------------------------------------

if ! command -v git >/dev/null 2>&1; then
  echo "❌ Git is required but not installed."
  echo "Install Xcode Command Line Tools first:"
  echo "  xcode-select --install"
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "❌ Homebrew is required but not installed."
  echo "Install Homebrew first:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# -------------------------------------------------
# Detect Homebrew path (Intel / Apple Silicon)
# -------------------------------------------------

BREW_PREFIX="/usr/local"
if [ -d "/opt/homebrew" ]; then
  BREW_PREFIX="/opt/homebrew"
fi

eval "$($BREW_PREFIX/bin/brew shellenv)"

# -------------------------------------------------
# Update Homebrew
# -------------------------------------------------

echo "Updating Homebrew..."
brew update
brew upgrade

# -------------------------------------------------
# Install latest Bash (via Homebrew)
# -------------------------------------------------

echo "Installing latest Bash..."
brew install bash

BASH_PATH="$BREW_PREFIX/bin/bash"

# Add new Bash to allowed shells if missing
if ! grep -q "$BASH_PATH" /etc/shells; then
  echo "$BASH_PATH" | sudo tee -a /etc/shells
fi

# Change default shell to new Bash
chsh -s "$BASH_PATH"

# -------------------------------------------------
# Install essential CLI tools
# -------------------------------------------------

echo "Installing essential CLI utilities..."
brew install wget htop tree neovim

# -------------------------------------------------
# Install NVM
# -------------------------------------------------

echo "Installing NVM..."
brew install nvm

mkdir -p ~/.nvm

PROFILE="$HOME/.bash_profile"

# Append NVM setup to bash profile
cat << 'EOF' >> "$PROFILE"
export NVM_DIR="$HOME/.nvm"
source "$(brew --prefix nvm)/nvm.sh"
EOF

# Load NVM immediately
. "$PROFILE"

# Install Node.js LTS
echo "Installing Node.js LTS via NVM..."
nvm install --lts
nvm use --lts

# -------------------------------------------------
# Install other packages
# -------------------------------------------------

echo "Install other packages..."
brew install readline nmap curl
brew install heroku docker flutter bchunk android-platform-tools scrcpy wine-stable winetricks 
brew install --cask iterm2 

# -------------------------------------------------
# Configure Git
# -------------------------------------------------

#echo "Configuring Git..."
#read -p "Enter Git username: " GIT_NAME
#read -p "Enter Git email: " GIT_EMAIL

#git config --global user.name "$GIT_NAME"
#git config --global user.email "$GIT_EMAIL"
#git config --global init.defaultBranch main

# Save credentials in macOS Keychain
#git config --global credential.helper osxkeychain

#echo "Git configured. If you want, set up GPG for signed commits separately."

# -------------------------------------------------
# Create _data directory
# -------------------------------------------------

echo "Creating _data directory..."
mkdir -p ~/_data/code/project/

# todo: клонировать сюда репозиторий с шаблоном для новых проектов, который будет включать проект airdrop,
# с помощью которого будет происходит загрузка программ с телефона по локальному вай-фай,
# затем распаковка архива и установка программ на компьютер, для моей версии macOS.

# -------------------------------------------------
# Add aliases
# -------------------------------------------------

echo "Adding terminal aliases..."
cat << 'EOF' >> "$PROFILE"
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
alias update='brew update && brew upgrade'
EOF

# Reload profile
. "$PROFILE"

echo "First setup completed successfully."


