#!/bin/bash

for FILE in ~/plugins/fo-*; do
    echo "$FILE"
    cd "$FILE" || exit;
    cp -f ~/.config/php-cs-fixer.dist.php .php-cs-fixer.dist.php
    cp -f ~/.config/.phpcs.xml.dist .
    cp -f ~/.config/editorconfig .editorconfig
    cd ../
done
