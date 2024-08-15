# `~/.dotfiles`

## Installation

```bash
curl -L https://raw.github.com/adeonir/dotfiles/main/install.sh | bash
```

> This repository contains various configuration files and scripts to set up a development environment.

## Environment Setup

The script install/environment.sh sets up the development environment by configuring various tools and settings, including:

- Installing Homebrew and essential packages
- Setting up fnm (Fast Node Manager) for managing Node.js versions
- Configuring Oh My Zsh and Zinit for Zsh customization
- Applying the Catppuccin theme for the Warp terminal
- Configuring the Starship prompt
- Setting up Better Vim with custom configurations

These scripts ensure that your development environment is consistent and ready to use.

### Homebrew

Homebrew is a package manager for macOS (or Linux) that simplifies the installation of software. The script uses Homebrew to install various applications and tools.

### fnm (Fast Node Manager)

fnm is a fast and simple Node.js version manager, built in Rust. It allows you to easily switch between different versions of Node.js.

### Better Vim

Better Vim is a customized configuration for Vim, aimed at improving the default experience with additional plugins and settings. The configuration file can be found at settings/better-vim/better-vim.lua.

### Oh My Zsh

Oh My Zsh is an open-source, community-driven framework for managing your Zsh configuration. It comes bundled with a ton of helpful functions, helpers, plugins, themes, and more.

### Zinit

Zinit is a flexible and fast Zsh plugin manager that allows you to load plugins and configure them in a declarative manner.

### Catppuccin

Catppuccin is a soothing pastel theme for various applications. The Warp terminal theme configuration can be found at settings/warp/catppuccin_macchiato.yml.

### Starship

Starship is a cross-shell prompt that is fast, customizable, and minimalistic. The configuration file can be found at settings/starship.toml.

### Rbenv

Check the latest Ruby version available and install it by running the following commands:

```bash
rbenv install -l
rbenv install <version>
```

Then, set the global Ruby version:

```bash
rbenv global <version>
```

### MySQL

The MySQL installation script will prompt you to set a root password. After installation, you can start the MySQL service with the following command:

```bash
brew services start mysql
mysql_secure_installation
```

Then connect to the MySQL server:

```bash
mysql -u root -p
```

## Software Installation

The script `install/softwares.sh` installs the following software using Homebrew Cask:

1Password
Arc
ChatGPT
Clockify
Discord
Docker
Figma
Font Fira Code Nerd Font
Google Chrome
Notion Calendar
Raycast
Setapp
Slack
Spotify
Telegram
Visual Studio Code
Warp
WhatsApp
Zoom

## Settings

The script `install/settings.sh` sets up various configuration files:

- .aliases: settings/.aliases
- .editorconfig: settings/.editorconfig
- .functions: settings/.functions
- .gitconfig: settings/git/.gitconfig
- .gitignore: settings/git/.gitignore
- .npmrc: settings/.npmrc
- .zprofile: settings/.zprofile
- .zshrc: settings/.zshrc
- BetterVim configuration: settings/better-vim/better-vim.lua
- Starship prompt: settings/starship.toml
- VSCode settings: settings/vscode/settings.json
- Warp theme: settings/warp/catppuccin_macchiato.yml

---

Inspired by Willian Justen [dotfiles](https://github.com/willianjusten/dotfiles)
