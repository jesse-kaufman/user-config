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


# DOCKER ALIASES
alias dcup='docker compose up -d'
alias dcu='docker compose up -d'
alias dcdn='docker compose down'
alias dcd='docker compose down'
alias dcdown='docker compose down'
alias dcstart='docker compose start'
alias dcstop='docker compose stop'
alias dcpull='docker compose pull'

alias dc='docker container'
alias dci='docker container inspect'
alias dcl='docker container list --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Image}}"'
alias dcla='docker container list -a --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Image}}"'

alias di='docker image'
alias dip='docker image pull'
alias dil='docker image list'
alias dila='docker image list -a'

alias dn='docker network'
alias dni='docker network inspect'
alias dnl='docker network list'

alias dl='docker logs'
alias dlogs='docker logs'
alias dlog='docker logs'
alias dlogs='docker logs'

alias ds='docker stats'

# MAKE SERVICE ALWAYS USE SUDO
alias service='sudo service'
alias systemctl='sudo systemctl'
alias apt='sudo apt'

alias more='less'
