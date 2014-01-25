# bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi prompt editing
set -o vi

# XXX: This is just a hack b/c noone has terminfo for termite
export TERM=xterm-color

export EDITOR=gvim
export SUDO_EDITOR="rgvim -f"

export CC=clang
export CXX=clang++

# ARM toolchain for raspberry pi development
export PATH=$PATH:$HOME/programming/builds/pi/tools/arm-bcm2708/arm-bcm2708hardfp-linux-gnueabi/bin
# Small utility scripts
export PATH=$PATH:$HOME/programming/scripts/

# Instead of the lo, use unix socket to connect to mpd
export MPD_HOST=/home/scott/.mpd/socket

# Color
alias ls='ls --color=auto --group-directories-first'
alias grep='grep -n --color=auto'
# Convenience
alias l='ls'
alias ll='ls -hal'
alias cls='clear && pwd && ls --color=auto --group-directories-first'
alias v='gvim'
alias vv='vim'
alias sx='startx'
alias du='du -h'
alias def='sdcv'
alias img='sxiv'
alias imgf='sxiv -d'
alias wcam='wxcam'
alias wcam-config='guvcview'
alias videdit='openshot'
alias allinstalled="pacman-color -Qei | awk '/^Name/ { name=\$3 } /^Groups/ { if ( \$3 != \"base\" && \$3 != \"base-devel\" ) { print name } }'"
alias updatemirrors='sudo reflector -l 5 --sort rate --save /etc/pacman.d/mirrorlist'
cl() {
    # cd to last positional argument and pass the rest to ls
    cd "${@: -1}" && ls "${@:1:$#-1}"
}

cll() {
    cl -hal "$@"
}


# Less (heh) colored output
export LESS="-R"
# More ls colors
eval $(dircolors -b)
# Man page colors
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
                man "$@"
}

#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
PS1="\[\033[1;37m\]($(echo '\[\033[01;32m\]\u@\h')\[\033[1;37m\])\$(if [[ \$? != 0 ]]; then echo \"\342\224\200(\[\033[01;31m\]\342\234\227\[\033[1;37m\])\"; fi)\[\033[1;37m\]\342\224\200(\[\033[1;32m\]\W\[\033[1;37m\])\342\224\200$ \[\033[0m\]"

