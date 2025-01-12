#!/usr/bin/env bash

# ログインシェルをzshに変更する
# chsh -s /bin/zsh

# 編集する際の心得　自分で意味分かんないやつコピペすんな

# コマンドヒストリめっちゃ長く履歴保持させとく
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

PROMPT='[%n@%m]# '
RPROMPT='[%d]'

# alias系 ###############################################################################################################################################################################################################
alias pro="code ~/.zshrc"
# 設定変えたら再読み込み
alias re='. ~/.zshrc'

# 事故防止
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias mkdir='mkdir -p'

# 上の階層へ移動するやつ
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# lsの色設定
# Always use color output for `ls`
alias -g ls="eza --icons"
alias ll="ls -l"
alias la="ls -al"

alias -g grep='rg'
alias cat='bat'
# zsh ########################################################################################################################################################################################################################
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

# zshの拡張機能のsource

# zsh option
setopt print_eight_bit      # 日本語ファイル名を表示可能にする
setopt no_flow_control      # フローコントロールを無効にする
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt auto_cd              # ディレクトリ名だけでcdする
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_ignore_space    # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks   # ヒストリに保存するときに余分なスペースを削除する
setopt nocorrect            # コマンドのスペルをミスして実行した場合に候補を表示しない
setopt no_beep              # ビープ音を鳴らさない

# starship有効化
eval "$(starship init zsh)"

# sheldon有効化
eval "$(sheldon source)"
eval "$(mise activate zsh)"
