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


# Core Docker commands
alias dcu='docker compose up -d'
alias dcdn='docker compose down'
alias dcstart='docker compose start'
alias dcstop='docker compose stop'
alias dcr='docker compose run'
alias dce='docker compose exec'
alias kopia='dce backup kopia'

# Docker build commands
alias dcbuild='docker compose build'
alias dcpush='docker compose push'
alias dcpull='docker compose pull'

alias dprune='docker system prune -af'

# Docker container commands
alias dc='docker container'
alias dci='docker container inspect'
alias dcl='docker container list --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Image}}"'
alias dcla='docker container list -a --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}\t{{.Image}}"'

# Docker volume commands
alias dv='docker volume'
alias dvi='docker volume inspect'
alias dvp='docker volume prune'
alias dvl='docker volume list'

# Docker image commands
alias di='docker image'
alias dii='docker image inspect'
alias dip='docker image prune'
alias dil='docker image list'

# Docker network commands
alias dn='docker network'
alias dni='docker network inspect'
alias dnl='docker network list'
alias dnp='docker network prune'

# Misc Docker commands
alias dl='docker logs'
alias ds='docker stats'
alias dsys='docker system'

# MAKE SERVICE ALWAYS USE SUDO
alias service='sudo service'
alias systemctl='sudo systemctl'
alias apt='sudo apt'
alias aptitude='sudo aptitude'

alias more='less'

alias fmount='findmnt --fstab'


alias idrive='dce idrive ./idrive'

alias ffmpeg='ffmpeg -hide_banner'
