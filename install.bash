#!/bin/bash
# install command if command is not installed
function install_command() {
  if ! command -v $1 >/dev/null 2>&1; then
    echo -e "\e[36mInstalling... $1\e[m\n"
    brew install $1
    echo -e "\e[36mInstalled $1\e[m\n"
  fi
}

DOT_DIRECTORY=$(
  cd $(dirname $0)
  pwd
)

cd ${DOT_DIRECTORY}

for f in .??*; do
  # 無視したいファイルやディレクトリはこんな風に追加してね
  [[ ${f} = ".git" ]] && continue
  [[ ${f} = ".gitignore" ]] && continue
  [[ ${f} = ".DS_Store" ]] && continue
  [[ ${f} = ".vscode" ]] && continue
  ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
done

# sheldon
if [ ! -d ${HOME}/.config ]; then
  # .configが存在しない場合は作成
  mkdir ${HOME}/.config
fi

if [ ! -d ${HOME}/.config/sheldon ]; then
  mkdir ${HOME}/.config/sheldon
  ln -snfv ${DOT_DIRECTORY}/zsh/.config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml
else
  ln -snfv ${DOT_DIRECTORY}/zsh/.config/sheldon/plugins.toml ${HOME}/.config/sheldon/plugins.toml
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
install_command eza
install_command fzf

# starship
if [ ! -d ${HOME}/.config ]; then
  # .configが存在しない場合は作成
  mkdir ${HOME}/.config
  ln -snfv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/starship.toml
else
  ln -snfv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/starship.toml
fi

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
