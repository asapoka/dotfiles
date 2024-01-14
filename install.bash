#!/bin/bash
DOT_DIRECTORY="${HOME}/dotfiles"

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

# sheldon
if [ ! -d ${HOME}/.config ]; then
  # .configが存在しない場合は作成
  mkdir ${HOME}/.config
else
  if [ ! -d ${HOME}/.config/sheldon ]; then
    mkdir ${HOME}/.config/sheldon
    ln -snfv ${DOT_DIRECTORY}/plugins.toml ${HOME}/.config/sheldon/plugins.toml
  else
    ln -snfv ${DOT_DIRECTORY}/plugins.toml ${HOME}/.config/sheldon/plugins.toml
  fi
fi

# staship
if [ ! -d ${HOME}/.config ]; then
  # .configが存在しない場合は作成
  mkdir ${HOME}/.config
  ln -snfv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/starship.toml
else
  ln -snfv ${DOT_DIRECTORY}/starship.toml ${HOME}/.config/starship.toml
fi

echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)

source ${HOME}/.zshrc
