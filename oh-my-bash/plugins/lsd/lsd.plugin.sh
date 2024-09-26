#
# LSD support
#

export LSD_PATH="$HOME/.cargo/bin"

# Use lsd instead of built-in ls if it's in our path
if command -v lsd &>/dev/null; then
    alias ls='lsd -N'
    alias gls='lsd' # coreutils
    alias ltr='ls --tree'
else
    alias ls='ls -hF --color=auto'
fi
