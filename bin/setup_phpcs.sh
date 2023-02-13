#!/bin/bash

current_phpcs=$(which phpcs)

severity=1

# installed_paths="./vendor/phpcompatibility/php-compatibility,./vendor/phpcsstandards/phpcsdevtools,./vendor/phpcsstandards/phpcsextra,./vendor/phpcsstandards/phpcsutils,./vendor/wp-coding-standards/wpcs,$HOME/.composer/vendor/phpcompatibility/php-compatibility,$HOME/.composer/vendor/phpcsstandards/phpcsdevtools,$HOME/.composer/vendor/phpcsstandards/phpcsextra,$HOME/.composer/vendor/phpcsstandards/phpcsutils,$HOME/.composer/vendor/wp-coding-standards/wpcs,"
installed_paths="$HOME/.composer/vendor/phpcompatibility/php-compatibility,$HOME/.composer/vendor/phpcsstandards/phpcsdevtools,$HOME/.composer/vendor/phpcsstandards/phpcsextra,$HOME/.composer/vendor/phpcsstandards/phpcsutils,$HOME/.composer/vendor/wp-coding-standards/wpcs,"

echo -e "Setting installed_paths for $current_phpcs:\n"
$current_phpcs --config-set installed_paths "$installed_paths"
$current_phpcs --config-set severity $severity

global_composer_phpcs="$HOME/.composer/vendor/bin/phpcs"

if [[ $current_phpcs != "$global_composer_phpcs" ]]; then
    echo -e "\n\nSetting installed_paths for $current_phpcs:\n"
    $global_composer_phpcs --config-set installed_paths "$installed_paths"
    $global_composer_phpcs --config-set severity $severity
fi

mason_phpcs="$HOME/.local/share/nvim/mason/bin/phpcs"

if [[ -f $mason_phpcs ]]; then
    echo -e "\n\nSetting installed_paths for $mason_phpcs:\n"
    $mason_phpcs --config-set installed_paths "$installed_paths"
    $mason_phpcs --config-set severity $severity
fi
