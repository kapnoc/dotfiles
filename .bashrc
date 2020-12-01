# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

set -o vi

# Stop Ctrl-S & Ctrl-Q signals
stty -ixon

# enter command in history instantly, not just when bash exits
export PROMPT_COMMAND='history -a; history -r'

PS1="$(echo -ne '\[\e[1;32m\]\$>\[\e[0m\]') "

export EDITOR='nvim'
export PAGER='less -R'

# colour aliases
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias tree='tree -C'

# common use aliases
alias ..='cd ..'
alias cl='clear'
alias ll='ls -l'
alias la='ls -la'
alias ne='emacs -nw'
alias vv='nvim'
alias aled="startx -- vt1"

# git aliases
alias ga='git add'
alias gc='git checkout'
alias gco='git commit'
alias gd='git diff'
alias gl='git log'
alias gpl='git pull'
alias gps='git push'
alias gs='git status'

# less used aliases
wttr()
{
	curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Nancy}"
}

PATH="$PATH:$HOME/.local/bin"
