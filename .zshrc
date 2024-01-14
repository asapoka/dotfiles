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

# 事前の環境変数設定
# Linux系とmacOS系でLSCOLORSの設定内容違うので、利用環境に合わせてexportする
if ls --color >/dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
  export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
  colorflag="-G"
  export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

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
alias ls="command ls ${colorflag}"
# List all files colorized in long format
alias ll="ls -lF ${colorflag}"
# List all files colorized in long format, excluding . and ..
alias la="ls -lAF ${colorflag}"
# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# grepの色設定
# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
  /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

fpath=(/usr/local/share/zsh-completions $fpath)

# コマンドのサブコマンドを入力補完する zsh-completions の設定
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit && compinit
fi

# zsh option
setopt print_eight_bit      # 日本語ファイル名を表示可能にする
setopt no_flow_control      # フローコントロールを無効にする
setopt interactive_comments # '#' 以降をコメントとして扱う
setopt auto_cd              # ディレクトリ名だけでcdする
setopt share_history        # 同時に起動したzshの間でヒストリを共有する
setopt hist_ignore_all_dups # 同じコマンドをヒストリに残さない
setopt hist_ignore_space    # スペースから始まるコマンド行はヒストリに残さない
setopt hist_reduce_blanks   # ヒストリに保存するときに余分なスペースを削除する
setopt nocorrect            #コマンドのスペルをミスして実行した場合に候補を表示しない

# zshの入力補完とコマンドシンタックスハイライト
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# starship有効化
eval "$(starship init zsh)"

# sheldon有効化
eval "$(sheldon source)"
