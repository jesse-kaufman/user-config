
# Core Docker commands
alias dcu='docker compose up -d'
alias dcdn='docker compose down'
alias dcstart='docker compose start'
alias dcstop='docker compose stop'
alias dcr='docker compose run'
alias dce='docker compose exec'

# Docker build commands
alias dcbuild='docker compose build'
alias dcpush='docker compose push'
alias dcpull='docker compose pull'
alias dcpul='dcpull'

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
alias dprune='docker system prune -af'

# Misc Docker commands
alias dl='docker logs'
alias ds='docker stats'
alias dsys='docker system'

# Aliases for running Docker compose exec commands from any directory
alias dcexec='docker compose -f ~/../containers/docker-compose.yaml exec -it '
alias idrive='dcexec idrive ./idrive'
alias kopia='dcexec backup kopia'
alias subsai='dcexec subs subsai --format srt --destination-folder /subs'

alias ve='node ~/github/video-edit/src/app.js'

alias vobsub2srt='docker compose --file /home/containers/vobsub2srt/docker-compose.yaml exec vobsub2srt vobsub2srt'
