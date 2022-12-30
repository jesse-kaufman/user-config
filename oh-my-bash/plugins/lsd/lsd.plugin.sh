#
# LSD support
#
if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
  echo "exporting path"
  export PATH=$HOME/.cargo/bin:$PATH
fi

# Use lsd instead of built-in ls if it's in our path
if command -v lsd &> /dev/null
then
  echo "lsd\n"
  alias ls='lsd'
else
  alias ls='ls -hF --color=auto' # base ls command that the rest inherit
fi
