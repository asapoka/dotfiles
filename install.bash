#!/usr/bin/env bash

DOTFILES="$(pwd)"
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
function install_command() {
  if ! command -v $1 >/dev/null 2>&1; then
    title "brew install"
    info "Installing... $1"
    brew install $1
    info "Installed $1"
  fi
}

DOT_DIRECTORY=$(
  cd $(dirname $0)
  pwd
)

cd ${DOT_DIRECTORY}
title "Creating symlinks"
for f in .??*; do
  # 無視したいファイルやディレクトリはこんな風に追加してね
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  [[ ${f} = ".DS_Store" ]] && continue
  [[ ${f} = ".vscode" ]] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

if [ ! -d ${HOME}/.config/sheldon ]; then
  warning ".config/sheldon directory not found. create ~/.config/sheldon"
  mkdir ${HOME}/.config/sheldon
  ln -snfv ${DOT_DIRECTORY}/zsh/.config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml
else
  ln -snfv ${DOT_DIRECTORY}/zsh/.config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml
fi

# starship
if [ ! -d ${HOME}/.config ]; then
  warning ".config/sheldon directory not found. create ~/.config/sheldon"
  mkdir ${HOME}/.config
  ln -snfv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/starship.toml
else
  ln -snfv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/starship.toml
fi

# alacritty
if [ ! -d ${HOME}/.config/alacritty ]; then
  warning ".config/alacritty directory not found. create ~/.config/alacritty"
  mkdir -p ${HOME}/.config/alacritty
  ln -snfv ${DOT_DIRECTORY}/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml
else
  ln -snfv ${DOT_DIRECTORY}/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml
fi

# brew eval
case "${OSTYPE}" in
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

install_command sheldon
install_command starship
install_command lsd
install_command fzf
install_command mise

success "Deploy dotfiles complete!"
