#!/usr/bin/env bash

#
# Dev tools like linters, formatters, etc
#

# Set uncrustify config file.
alias uncrustify='uncrustify -c ~/.config/uncrustify.cfg'

# Set shfmt options
alias shfmt='shfmt --indent=0 --case-indent --binary-next-line --space-redirects --keep-padding --func-next-line'

alias stylua='stylua --search-parent-directories'

alias yamlfmt="yamlfmt -conf=\$HOME/.config/yamlfmt.yml"
alias yamllint="yamllint -c \$HOME/.config/yamllint.yml"

alias phpstan='phpstan --memory-limit=512M'

alias phpcs='phpcs --severity=1'
alias phpcss='phpcs --report=summary'
alias pcss='phpcss'
alias pcs='phpcs'

alias phpcbf='phpcbf --severity=1'
alias pcf='phpcbf'
