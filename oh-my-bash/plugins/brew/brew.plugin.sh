# shellcheck shell=bash

#
# Homebrew support for OMB
#

# Hide hints.
export HOMEBREW_NO_ENV_HINTS=1

# Find Homebrew dir.
if [ -d "/opt/homebrew" ]; then
    export BREW_PATH="/opt/homebrew"
elif [ -d "/home/linuxbrew/.linuxbrew/" ]; then
    export BREW_PATH="/home/linuxbrew/.linuxbrew"
elif [ -d "/usr/local" ]; then
    export BREW_PATH="/usr/local"
fi

# Add aliases for all GNU apps in the coreutils cask dir
# shellcheck disable=2045
if [ -d "$BREW_PATH/Cellar/coreutils" ]; then
    for FILE in gcp gtail gtar; do

        # Only act on files that start with g.
        if [[ $FILE != g* ]]; then
            continue
        fi

        # Skip some tools to avoid weirdness
        if [ "$FILE" = "gls" ] || [[ $FILE == gdb* ]] || [ "$FILE" = "g[" ] || [ "$FILE" = "gecho" ] || [ "$FILE" = "gprintf" ]; then
            continue
        fi

        # Create the alias.
        # shellcheck disable=2001,2139
        alias "$(echo "$FILE" | sed 's/g//')"="$FILE"
    done
fi
