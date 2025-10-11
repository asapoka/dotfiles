#!/usr/bin/env bash

# Set DOT_DIR to current directory if not set (for CI environments)
# or default to $HOME/dotfiles (for regular installations)
if [ -z "${DOT_DIR:-}" ]; then
  if [ -f "$(pwd)/scripts/install.bash" ]; then
    DOT_DIR="$(pwd)"
  else
    DOT_DIR="$HOME/dotfiles"
  fi
fi

set -euo pipefail

source $DOT_DIR/lib/colors.bash

# install command if command is not installed
install_command() {
  if has "cargo"; then
    if ! command -v $1 >/dev/null 2>&1; then
      title "cargo install"
      info "Installing... $1"
      cargo install $1
      info "Installed $1"
    fi
  fi
}

has() {
  type "$1" >/dev/null 2>&1
}

# dotfilesディレクトリが無い場合git cloneする
# CI環境では既にcheckoutされているのでスキップ
if [ ! -d ${DOT_DIR} ] && [ -z "${CI:-}" ]; then
  info "dotfiles doesn't exist so get it"
  if has "git"; then
    git clone https://github.com/asapoka/dotfiles.git ${DOT_DIR}
  elif has "curl" || has "wget"; then
    TARBALL="https://github.com/asapoka/dotfiles/archive/master.tar.gz"
    if has "curl"; then
      curl -L ${TARBALL} -o master.tar.gz
    else
      wget ${TARBALL}
    fi
    tar -zxvf master.tar.gz
    rm -f master.tar.gz
    mv -f dotfiles-master "${DOT_DIR}"
  else
    error "curl or wget or git required"
    exit 1
  fi
fi

cd ${DOT_DIR}
title "Creating symlinks"

# home directory configs
ln -snfv ${DOT_DIR}/config/zsh/.zshrc ${HOME}/.zshrc
ln -snfv ${DOT_DIR}/home/.gitconfig ${HOME}/.gitconfig
ln -snfv ${DOT_DIR}/home/.ripgreprc ${HOME}/.ripgreprc
# ~/.config directory
if [ ! -d ${HOME}/.config ]; then
  mkdir -p ${HOME}/.config
fi

# starship
ln -snfv ${DOT_DIR}/config/starship.toml ${HOME}/.config/starship.toml

# sheldon
if [ ! -d ${HOME}/.config/sheldon ]; then
  mkdir -p ${HOME}/.config/sheldon
fi
ln -snfv ${DOT_DIR}/config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml

# alacritty
if [ ! -d ${HOME}/.config/alacritty ]; then
  mkdir -p ${HOME}/.config/alacritty
fi
ln -snfv ${DOT_DIR}/config/alacritty/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

# alacritty themes
if [ ! -d ${HOME}/.config/alacritty/themes ]; then
  mkdir -p ${HOME}/.config/alacritty/themes
fi
ln -snfv ${DOT_DIR}/config/alacritty/themes/blood_moon.toml ${HOME}/.config/alacritty/themes/blood_moon.toml

# nvim
ln -snfv ${DOT_DIR}/config/nvim ${HOME}/.config/nvim

# claude
if [ ! -d ${HOME}/.claude ]; then
  mkdir -p ${HOME}/.claude
fi
ln -snfv ${DOT_DIR}/.claude/CLAUDE.md ${HOME}/.claude/CLAUDE.md


install_command lsd
install_command starship
install_command lsd
install_command skim # fzfの代替
install_command bat
install_command fd-find
install_command ripgrep
install_command shelldon
success "Deploy dotfiles complete!"
