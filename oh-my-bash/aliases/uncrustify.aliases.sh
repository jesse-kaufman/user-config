#!/usr/bin/env bash

if command -v uncrustify &> /dev/null; then
  alias uncrustify='uncrustify -c ~/.config/uncrustify.cfg'
else
  alias ls='ls -hF --color=auto'
fi
