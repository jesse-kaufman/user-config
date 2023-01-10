#!/usr/bin/env bash

#
# Dev tools like linters, formatters, etc
#

# Set uncrustify config file.
alias uncrustify='uncrustify -c ~/.config/uncrustify.cfg'

# Set shfmt options
alias shfmt='shfmt --indent=0 --case-indent --binary-next-line --space-redirects --keep-padding --func-next-line'

alias stylua='stylua --search-parent-directories'
