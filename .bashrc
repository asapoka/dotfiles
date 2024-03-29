#!/usr/bin/env bash

#alias
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

#alias eza
alias ls="eza --icons"
# List all files colorized in long format
alias ll="eza -l --icons"
# List all files colorized in long format, excluding . and ..
alias la="eza -la --icons"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# brew path
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
