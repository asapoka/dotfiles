#!/usr/bin/env bash

DOT_DIR="$HOME/dotfiles"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
  echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
  echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
  echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
  exit 1
}

warning() {
  echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
  echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
  echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

# install command if command is not installed
install_command() {
  if has "cargo"; then
    if ! command -v $1 >/dev/null 2>&1; then
      title "cargo install"
      info "Installing... $1"
      cargo install $1 --locked
      info "Installed $1"
    fi
  fi
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

# starship
if [ ! -d ${HOME}/.config ]; then
  warning ".config/sheldon directory not found. create ~/.config/sheldon"
  mkdir -p ${HOME}/.config
  ln -snfv ${DOT_DIR}/starship.toml ${HOME}/.config/starship.toml
else
  ln -snfv ${DOT_DIR}/starship.toml ${HOME}/.config/starship.toml
fi

# sheldon
if [ ! -d ${HOME}/.config/sheldon ]; then
  warning ".config/sheldon directory not found. create ~/.config/sheldon"
  mkdir -p ${HOME}/.config/sheldon
  ln -snfv ${DOT_DIR}/zsh/.config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml
else
  ln -snfv ${DOT_DIR}/zsh/.config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml
fi

# alacritty
if [ ! -d ${HOME}/.config/alacritty ]; then
  warning ".config/alacritty directory not found. create ~/.config/alacritty"
  mkdir -p ${HOME}/.config/alacritty
  ln -snfv ${DOT_DIR}/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml
else
  ln -snfv ${DOT_DIR}/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml
fi

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

success "Deploy dotfiles complete!"
