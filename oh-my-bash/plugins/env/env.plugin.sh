#!/usr/bin/env bash

###############################
# Setup environment variables
# Copyright © 2023 Jesse Kaufman.
# All rights reserved.
#

# Don't ignore any history items when recalling.
HISTIGNORE=

# Local variable for paths to prepend to PATH.
GLX_PATHS=""

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

##############
# SETUP PATH
#

#
# Add Homebrew to path
#
if [[ ":$BREW_PATH:" != "::" ]] && [[ -d "$BREW_PATH/bin" ]]; then
    # Brew bin dir exists.
    GLX_PATHS="$BREW_PATH/opt/llvm/bin:$PATH"

    # Brew bin dir isn't in path already.
    if [[ ":$PATH:" != *":$BREW_PATH/bin:"* ]]; then
        # Prepend bin dir to local var of paths
        GLX_PATHS="$BREW_PATH/bin:$GLX_PATHS"
        GLX_PATHS="$BREW_PATH/sbin:$GLX_PATHS"
    fi

    ncurses_path="$BREW_PATH/opt/ncurses/bin"
    # Add opt/ncurses/bin if it exists
    if [[ -d "$ncurses_path" ]]; then
        # Add PHP bin dir
        export PATH="$ncurses_path:$PATH"
    fi

    php_path="$BREW_PATH/php@7.4" # TODO: Remove hardcoded ver
    # Add PHP bin/sbin dir if php directory exists
    if [[ -d "$php_path" ]]; then
        export PATH="$php_path/bin:$PATH"
        export PATH="$php_path/sbin:$PATH"
    fi

    tar_path="$BREW_PATH/opt/gnu-tar/libexec/gnubin"
    # Add tar bin if it exists
    if [[ -d "$tar_path" ]]; then
        export PATH="$tar_path:$PATH"
    fi

fi

#
# Add global Cargo to path
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
# Add local composer to path
#
if [[ ":$PATH:" != *":./vendor/bin:"* ]]; then
    GLX_PATHS="./vendor/bin:$GLX_PATHS"
fi



#
# Add global composer to path
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
# Add Mason-vim bin dir to path
#
MASON_PATH="$HOME/.local/share/nvim/mason/bin"
if [[ ":$PATH:" != *":$MASON_PATH:"* ]]; then
    GLX_PATHS="$MASON_PATH:$GLX_PATHS"
fi

#
# Add ~/.config/bin/ to path
#
GLX_PATHS="$HOME/.config/bin:$GLX_PATHS"

#
# Prepend our paths to $PATH
#
export PATH="${GLX_PATHS}${PATH}"

###########################
# OTHER ENV VARS / CONFIG
#

#
# Don't autocomplete vars for cd
#
shopt -u cdable_vars
