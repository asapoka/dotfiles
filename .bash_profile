# .bash_profile

# Primary Prompt
export PS1="[\u@\h:\W]\$ "

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

alias ll='ls -al'
