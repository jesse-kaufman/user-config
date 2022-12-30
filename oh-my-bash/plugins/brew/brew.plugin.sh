#
# Homebrew support for OMB
#

# Find Homebrew bin dir.
if [ -d "/opt/homebrew" ]; then
  BREW_PATH="/opt/homebrew/bin"
elif [ -d "/usr/local" ]; then
  BREW_PATH="/opt/homebrew/bin"
fi

# Add Homebrew bin dir to path (if it isn't already).
if [[ ":$PATH:" != *":$BREW_PATH:"* ]]; then
  export PATH=$BREW_PATH:$PATH
fi

# Add aliases for all GNU apps in the coreutils cask bin dir
for FILE in `ls -1 "${BREW_PATH}/"`; do

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
  alias `echo $FILE | sed 's/g//'`="${FILE}"
done
