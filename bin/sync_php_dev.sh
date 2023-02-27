#!/bin/bash

for FILE in ~/plugins/fo-* ~/fo/; do
    echo "$FILE"
    cd "$FILE" || exit;

    # Sync PHP-CS-Fixer config
    cp -f ~/.config/.php-cs-fixer.dist.php .

    # Sync PHP Code Sniffer config
    cp -f ~/.config/.phpcs.xml.dist .

    # Sync editorconfig
    cp -f ~/.config/editorconfig .editorconfig

    cd ../
done
