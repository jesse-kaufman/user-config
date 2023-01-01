#
# LSD support
#
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi

# Use lsd instead of built-in ls if it's in our path
if command -v lsd &> /dev/null; then
  alias ls='lsd'
else
  alias ls='ls -hF --color=auto'
fi
