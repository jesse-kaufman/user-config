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
