# CLAUDE.md

必ず日本語で回答してください
ファイルを移動する際は git mv を使用して git の履歴を保持してください。
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a cross-platform dotfiles repository that provides automated development environment setup for Linux, macOS, and Windows. The repository uses symlinks to deploy configuration files and installs modern CLI tools for enhanced productivity.

## Installation Commands

**Unix/Linux/macOS:**

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/asapoka/dotfiles/master/scripts/install.bash)"
```

**Windows:**

```powershell
iwr "https://raw.githubusercontent.com/asapoka/dotfiles/refs/heads/master/scripts/install.ps1" | iex
```

**Font Installation (macOS):**

```bash
brew install font-hackgen-nerd
```

## Repository Structure

- `home/` - Configuration files for home directory
  - `.zshrc` - Zsh configuration with aliases and plugin setup
  - `.gitconfig` - Git configuration
  - `.ripgreprc` - Ripgrep search configuration
- `config/` - Configuration files for ~/.config directory
  - `starship.toml` - Starship prompt configuration
  - `alacritty/alacritty.toml` - Alacritty terminal configuration
  - `sheldon/plugins.toml` - Zsh plugin manager configuration
  - `nvim/` - Neovim configuration (Kickstart.nvim based)
  - `powershell/` - PowerShell configuration and modules
- `scripts/` - Installation and configuration scripts
  - `install.bash` - Main Unix/Linux installation script
  - `install.ps1` - Windows PowerShell installation script
  - `macos.bash` - macOS-specific system configuration
- `lib/colors.bash` - Color output functions for bash scripts

## Key Technologies

- **Shell**: Zsh with Starship prompt and Sheldon plugin manager
- **Editor**: Neovim with Kickstart.nvim configuration
- **Terminal**: Alacritty with custom themes
- **Package Manager**: Homebrew (Unix/macOS), winget (Windows)
- **Font**: HackGen Console NF (Nerd Font)

## Installed Tools

Core tools installed via the installation script:

- `sheldon` - Fast shell plugin manager
- `starship` - Cross-shell prompt
- `lsd` - Modern ls replacement
- `fzf` - Fuzzy finder
- `bat` - Enhanced cat command
- `fd` - Modern find replacement
- `ripgrep` - Fast grep alternative

## Architecture Notes

- Uses symlinks for configuration deployment from `$HOME/dotfiles`
- Cross-platform compatibility with OS-specific logic
- Modular design with separate configuration directories
- PowerShell autoload system for Windows
- Backs up existing configurations before deployment
- Platform detection using `$OSTYPE` and PowerShell built-in variables

## Development Notes

- No formal testing framework or CI/CD configuration
- Installation scripts include safety checks and exit conditions
- Uses absolute paths from repository root for all configurations
- Color and messaging functions centralized in `lib/colors.bash`
- **File Movement**: Use `git mv` for moving files to maintain git history
