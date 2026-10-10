function fman() {
    man -k . | fzf --prompt='Man> ' | awk '{print $1}' | xargs -r man
}
# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackage
function bip() {
  local inst=$(brew search "$@" | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}
# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]ackage
function bup() {
  local upd=$(brew leaves | fzf -m)

  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackage (e.g. uninstall)
function bcp() {
  local uninst=$(brew leaves | fzf -m)

  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
function install() {
    local token
    token=$(brew search --casks "$1" | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew install --cask $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew home $token
        fi
    fi
}

# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
function uninstall() {
    local token
    token=$(brew list --casks | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepae of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew uninstall --cask $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew home $token
        fi
    fi
}

function menu(){
  mise run 
}

# ghqで管理されているリポジトリをfzfで選択して移動する
# README.mdをbatコマンドでプレビュー表示
function gcd() {
  local ghq_root repo

  if ! command -v ghq >/dev/null 2>&1; then
    echo 'ghq is not installed' >&2
    return 1
  fi

  # 選択したリポジトリへ移動 かつ
  # 右にリポジトリのディレクトリ詳細を表示
  local src=$(ghq list | fzf --preview "bat --color=always --style=header $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    cd "$(ghq root)/$src"
    zle accept-line
    zle reset-prompt

  fi
  zle -R -c
}

# Ctrl+G で ghq 管理のリポジトリを選択して移動する
# fzf のプレビューで README を表示する
zle -N gcd
bindkey '^g' gcd