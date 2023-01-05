#!/usr/bin/env bash

#
# Setup shell colors
#

if command -v vivid &>/dev/null; then
    # Use vivid for setting colors
    LS_COLORS="$(vivid generate one-dark)"
else
    # Fall back to dircolors
    eval "$(dircolors ~/.config/dircolors)"
fi

export LS_COLORS
