#!/usr/bin/env bash

##
# Setup environment variables like PATH
# Copyright © 2023 Jesse Kaufman. All rights reserved.
#

# Local variable for paths to prepend to PATH
GLX_PATHS=""

#
# Add Homebrew to path (if it isn't already).
#

# Check if directory exists.
if [[ ":$BREW_PATH:" != "::" ]] &&            # Variable is set. \
    [[ -d $BREW_PATH ]] &&                    # Directory exists. \
    [[ ":$PATH:" != *":$BREW_PATH:"* ]]; then # Isn't in path already.
    GLX_PATHS="$BREW_PATH:$GLX_PATHS"
fi

#
# Add global Cargo to path (if it isn't already).
#
CARGO_PATH="$HOME/.cargo/bin"
# Check if directory exists.
if [[ -d $CARGO_PATH ]]; then
    # Isn't in path already
    if [[ ":$PATH:" != *":$CARGO_PATH:"* ]]; then
        GLX_PATHS="$CARGO_PATH:$GLX_PATHS"
    fi
fi

#
# Add global composer to path (if it isn't already)
#
G_COMPOSER_PATH="$HOME/.composer/vendor/bin"
if [[ ":$PATH:" != *":$G_COMPOSER_PATH:"* ]]; then
    GLX_PATHS="$G_COMPOSER_PATH:$GLX_PATHS"
fi

#
# Add local composer to path (if it isn't already)
#
if [[ ":$PATH:" != *":./vendor/bin:"* ]]; then
    GLX_PATHS="./vendor/bin:$GLX_PATHS"
fi

#
# Prepend our paths to $PATH
#
export PATH="$GLX_PATHS:$PATH"
