#!/usr/bin/env bash

##
# Setup environment variables like PATH
# Copyright © 2023 Jesse Kaufman. All rights reserved.
#

# Don't ignore any history items when recalling.
HISTIGNORE=

# Local variable for paths to prepend to PATH.
GLX_PATHS=""

#
# Add Homebrew to path (if it isn't already).
#

# Variable is set.
if [[ ":$BREW_PATH:" != "::" ]] && \
    # Brew bin dir exists.
    [[ -d "$BREW_PATH/bin" ]]; then

        # Brew bin dir isn't in path already.
        if [[ ":$PATH:" != *":$BREW_PATH/bin:"* ]]; then \
            # Prepend bin dir to local var of paths
            GLX_PATHS="$BREW_PATH/bin:$GLX_PATHS"
        fi

        php_path="$BREW_PATH/php@7.4" # TODO: Remove hardcoded ver

        # Add PHP if it exists
        if [[ -d $php_path ]]; then
            # Add PHP bin dir
            export PATH="$php_path/bin:$PATH"
            # Add PHP sbin dir
            export PATH="$php_path/sbin:$PATH"
        fi
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
if [[ -d "$HOME/.composer/vendor/bin" ]]; then
    G_COMPOSER_PATH="$HOME/.composer/vendor/bin"
elif [[ -d "$HOME/.config/composer/vendor/bin" ]]; then
    G_COMPOSER_PATH="$HOME/.config/composer/vendor/bin"
fi

if [[ ":$G_COMPOSER_PATH:" != "::" ]]; then
    if [[ ":$PATH:" != *":$G_COMPOSER_PATH:"* ]]; then
        GLX_PATHS="$G_COMPOSER_PATH:$GLX_PATHS"
    fi
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
export PATH="${GLX_PATHS}${PATH}"

# Don't autocomplete vars for cd
shopt -u cdable_vars
