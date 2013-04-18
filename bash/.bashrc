# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# some more ls aliases
alias lg='ls --group-directories-first'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# exporting environment variables
export CVSROOT=":ext:smooney@pyrite.cs.iastate.edu:/home/other/design/cvsroot"
export CVS_RSH=ssh
export EDITOR=vim
#export JAVA_HOME=/usr/lib/jvm/java-6-sun
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/
export CASTROID_HOME=/home/sean/srccode/android/CastRoid_alaQ87
export PANC_HOME=/opt/DevTools/panini
alias panc='$PANC_HOME/bin/panc'

#useful aliases
alias ipc='ping google.com -c5'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias su_synaptic='gksudo synaptic'
alias pyjamas='/home/sean/.bin/pyjamas-0.5p1/bin/pyjsbuild'
alias pyrite='ssh -X smooney@pyrite.cs.iastate.edu'
alias jdc='/opt/CompilerTools/jd-gui'
alias coqdefs='java -jar /home/sean/.bin/CoqDefExtractor.jar'
alias javaj='java -jar /home/sean/.bin/JavaCompiler.jar'
alias panc='java -jar /home/sean/.bin/PaniniCompiler.jar'
alias pant='java -jar /home/sean/.bin/PaniniTranslator.jar'
alias pancII='java -jar /home/sean/.bin/pancII.jar'
alias jdumptree='java -jar /home/sean/.bin/JavaDumpTree.jar'
alias jdecompile='java -cp .:/opt/CompilerTools/sootNsmoke.jar COM.sootNsmoke.oolong.Gnoloo'
alias eclipse3_6='/opt/DevTools/eclipse-helios/eclipse'
alias eclipse_adt='/opt/DevTools/eclipse-3.6-Android/eclipse'
alias android='/opt/android-sdk/tools/android'
alias clb='latexmk -pdf -pvc'
alias cvs-up='cvs up -d'

alias cvs-add-all-new='cvs status|grep ^?|sed s/?//|xargs cvs add $1'

alias svnignore='python /home/sean/bin/svnignore.py'
#from snippits.dzone.com/posts/show/4722
alias svn-add-all-new='svn st|grep ^?|sed s/?//|xargs svn add $1'

#end from snippits
alias jsca-src='cd /home/sean/srccode/eclipse_workspaces/program-analysis/static-commutativity-git'
alias cd-ccs='cd /home/sean/srccode/java/analysis_examples/comm-case-study'

alias hibernate='sudo /etc/acpi/hibernate.sh'

#From a redditor.
#http://www.reddit.com/r/commandline/comments/w0x1a/i_made_a_shell_script_that_displays_a_random_man/c59am7q
alias randomman='man $(ls /usr/share/man/man1 | shuf | head -n 1 | cut -d '.' -f 1)'

alias testdone='playsound /usr/share/sounds/KDE-Sys-App-Negative.ogg'
alias playvideo='mplayer -fs'
alias nmaphome='nmap -sP 192.168.1.0/24'

alias git-recent-branches="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname)' | cut -d / -f 3-"


alias mineserv='java -jar -Xmx1024M -Xms1024M /home/sean/bin/minecraft/minecraft_server.jar'
alias minecraft='java -jar -Xmx1024M -Xms512M /home/sean/bin/minecraft/minecraft.jar'

#Set up a proxy through ssh. Must supply the port and host.
alias sshproxy='ssh -N -D'
#PAN_CP=.:/home/sean/.bin/panini_rt.jar

export ANDROID_HOME=/opt/android-sdk
PATH=~/bin:~/.cabal/bin:/usr/games:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

#PATH=$PATH:~/.cabal/bin:/home/sean/bin

#prefer the local version of cabal
#alias cabal=/home/sean/.cabal/bin/cabal

branch_color=$'\e[1;35m'
normal_colors=$'\e[m'
PS1="\u@\h:\W>\[$branch_color\]\$git_branch\[$normal_colors\] "

#java display workaround for XMonad
export _JAVA_AWT_WM_NONREPARENTING=1

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

fortune
