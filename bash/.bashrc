# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

#If not running interactively, do nothing
[ -z "$PS1" ] && return

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

export JAVA_HOME=/usr/lib/jvm/default-java

test -s ~/.alias && . ~/.alias || true

#HIST FILE CONTROL??
HISTCONTROL=ignoredups:ignorespace

HISTSIZE=1000
HISTFILESIZE=2000

shopt -s checkwinsize

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

if [ -n "$SSH_CLIENT" ]; then LBLSSH=":via-ssh"
fi
green=$'\e[1;32m'
branch_color=$'\e[1;35m'
normal_colors=$'\e[m'
PS1="\u\[\033[1;31m\]@\h$LBLSSH\[\033[0;33m\]\[\033[0m\]:\W\[\033[0m\]\[$branch_color\]\$git_branch\[$normal_colors\]\$ "

# set a fancy prompt
case "$TERM" in 
    xterm-color) color_prompt=yes;;
esac

if [ -x /usb/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export CVSROOT=":ext:smooney@pyrite.cs.iastate.edu:/home/other/design/cvsroot"

alias java_jmx='java -Dcom.sun.management.jmxremote'
#export LD_LIBRARY_PATH=/opt/dev_tools/tptpAC/bin:/opt/dev_tools/tptpAC/lib

#Append extra path pieces.
#PATH=$PATH:~/.cabal/bin:/home/sean/bin
PATH=~/.cabal/bin:/home/sean/bin:$PATH

function resetscreen {
    xrandr -s 1 && xrandr -s 0
}

#Show the git branch on the terminal
#FROM: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
function find_git_branch {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch=" ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=' (detached)'
            else
                git_branch=' (unknown)'
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

source /home/sean/bin/helpers.sh

