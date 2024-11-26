# shellcheck shell=bash

# Core aliases
#
alias sudo='sudo '
alias c='cd'
unalias mv
alias mv='mv -i'
alias grep="grep --exclude-dir={.git,'*node_modules*'} --exclude=.phpcs.cache --color=auto"
alias grepr="grep -R --exclude-dir={.git,'*node_modules*'} --exclude=.phpcs.cache"
alias grepv='grep -v'
alias pw='pwd'
alias cmp='composer'

alias diff='diff --color=always'

alias less='less -FRXc'

colortail="$(which multitail)"

if [[ "${colortail}X" != "X" ]]; then
    alias ctail="colortail -k \$HOME/.config/colortail/default.conf"
else
    alias ctail='tail'
fi

if command -v editorconfig-checker &>/dev/null; then
    alias ec='editorconfig-checker'
elif command -v ec &>/dev/null; then
    alias editorconfig-checker='ec'
fi

alias tic='tic -sx'

# MAKE SERVICE ALWAYS USE SUDO
alias service='sudo service'
alias systemctl='sudo systemctl'
alias apt='sudo apt'
alias aptitude='sudo aptitude'

alias more='less'

alias fmount='findmnt --fstab'


alias ffmpeg='ffmpeg -hide_banner'
