# shellcheck shell=bash

#
# Homebrew support for OMB
#

# Hide hints.
export HOMEBREW_NO_ENV_HINTS=1

# Find Homebrew bin dir.
if [ -d "/opt/homebrew" ]; then
    export BREW_PATH="/opt/homebrew/bin"
elif [ -d "/home/linuxbrew/.linuxbrew/" ]; then
    export BREW_PATH="/home/linuxbrew/.linuxbrew/bin"
elif [ -d "/usr/local" ]; then
    export BREW_PATH="/usr/local/bin"
fi

# Add Homebrew bin dir to path (if it isn't already).
if [[ ":$PATH:" != *":$BREW_PATH:"* ]]; then
    export PATH=$BREW_PATH:$PATH
fi

# Add aliases for all GNU apps in the coreutils cask bin dir
for FILE in $(ls -1 "${BREW_PATH}/"); do

    # Only act on files that start with g.
    if [[ $FILE != g* ]]; then
        continue
    fi

    # Skip gls and gdb*
    if [ "$FILE" = "gls" ] || [[ $FILE == gdb* ]] || [ "$FILE" = "g[" ]; then
        continue
    fi

    # Create the alias.
    # NEWFILE=`echo $FILE | sed 's/g//'`
    # alias ${NEWFILE}="${FILE}"
    alias $(echo $FILE | sed 's/g//')="${FILE}"
done

export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
