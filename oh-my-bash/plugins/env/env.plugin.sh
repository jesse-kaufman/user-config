#!/usr/bin/env bash

if [[ ":$PATH:" != *":$HOME/.config/composer/vendor/bin:"* ]]; then
  export PATH=~/.config/composer/vendor/bin:$PATH
fi

if [[ ":$PATH:" != *":./vendor/bin:"* ]]; then
  export PATH=./vendor/bin:$PATH
fi
