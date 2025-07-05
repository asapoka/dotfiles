#!/usr/bin/env bash

DOT_DIR="$HOME/dotfiles"

set -euo pipefail

source $DOT_DIR/lib/colors.bash

# install command if command is not installed
install_command() {
  if has "brew"; then
    if ! command -v $1 >/dev/null 2>&1; then
      title "brew install"
      info "Installing... $1"
      brew install $1
      info "Installed $1"
    fi
  fi
}

has() {
  type "$1" >/dev/null 2>&1
}

# dotfilesディレクトリが無い場合git cloneする
if [ ! -d ${DOT_DIR} ]; then
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
for f in .??*; do
  # 無視したいファイルやディレクトリはこんな風に追加してね
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  [[ ${f} = ".DS_Store" ]] && continue
  [[ ${f} = ".vscode" ]] && continue
  ln -snfv ${DOT_DIR}/${f} ${HOME}/${f}
done

# home directory configs
ln -snfv ${DOT_DIR}/home/.zshrc ${HOME}/.zshrc
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

# nvim
ln -snfv ${DOT_DIR}/config/nvim ${HOME}/.config/nvim

# brew eval
if has "brew"; then
  case $(uname) in
  darwin*)
    # Mac
    # brew path
    eval $(/opt/homebrew/bin/brew shellenv)
    ;;
  linux*)
    # Linux
    # brew path
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    ;;
  esac
fi

install_command sheldon
install_command starship
install_command lsd
install_command fzf
install_command bat
install_command fd
success "Deploy dotfiles complete!"
