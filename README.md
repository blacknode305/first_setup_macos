# macOS Terminal First Setup 🚀

Automated setup script for macOS that prepares a fresh system for development and everyday terminal use.

## ✨ Features

- Installs latest Bash
- Installs essential CLI utilities
- Sets up Homebrew packages
- Clones required repositories
- Creates useful shell aliases
- Prepares development environment
- Speeds up new Mac setup

---

## 📦 What Gets Installed

- Latest Bash shell
- Git
- Node.js (optional)
- Common terminal tools (wget, htop, tree, etc.)
- Additional utilities via Homebrew

---

## ⚙️ Configuration

The script also:

- Configures Git (if needed)
- Creates helpful aliases
- Prepares directories
- Clones predefined repositories
- Optimizes terminal workflow

---

## 📦 Prerequisites

This script assumes the following tools are already installed:

- Apple Xcode Command Line Tools
- Git
- Homebrew

Install them before running the script:

```bash
xcode-select --install
```

If prompted, accept the Xcode license:

```bash
sudo xcodebuild -license accept
```

Verify installation:
```bash
git --version
```

Install Homebrew first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## 🚀 Usage

Clone the repository:

```bash
git clone https://github.com/blacknode305/first_setup_macos.git
```

Run the script:
```bash
cd first_setup_macos
chmod +x first_setup.sh
./first_setup.sh
```

---