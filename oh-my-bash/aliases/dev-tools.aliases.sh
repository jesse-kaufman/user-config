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

alias phpcs='phpcs --config-set installed_paths ./vendor/phpcompatibility/php-compatibility,./vendor/phpcsstandards/phpcsdevtools,./vendor/phpcsstandards/phpcsextra,./vendor/phpcsstandards/phpcsutils,./vendor/wp-coding-standards/wpcs,/Users/glandix/.composer/vendor/phpcompatibility/php-compatibility,/Users/glandix/.composer/vendor/phpcsstandards/phpcsdevtools,/Users/glandix/.composer/vendor/phpcsstandards/phpcsextra,/Users/glandix/.composer/vendor/phpcsstandards/phpcsutils,/Users/glandix/.composer/vendor/wp-coding-standards/wpcs,'
