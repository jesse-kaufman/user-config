#!/usr/bin/env bash

#
# Setup shell colors
#

if command -v vivid &>/dev/null; then
    # Use vivid for setting colors
    LS_COLORS="$(vivid generate one-dark)"
fi

export LS_COLORS
