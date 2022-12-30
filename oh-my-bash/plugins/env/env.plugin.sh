if [[ ":$PATH:" != *":$HOME/.config/composer/vendor/bin:"* ]]; then
  export PATH=$HOME/.config/composer/vendor/bin:$PATH
fi

if [[ ":$PATH:" != *":./vendor/bin:"* ]]; then
  export PATH=./vendor/bin:$PATH
fi
