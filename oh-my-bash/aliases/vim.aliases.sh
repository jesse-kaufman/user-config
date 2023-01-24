# shellcheck shell=bash

#
# vim/neovim aliases
#

if command -v vim.basic &>/dev/null; then
alias vim.basic='vim.basic'
else
    alias vim.basic='/usr/bin/vim'
fi

if command -v nvim &>/dev/null; then
    alias nvim='nvim -p'
    alias vim='nvim'
    alias n='nvim'
fi

alias v='vi'
alias vi='vim'
alias nw='vi ~/fo/inc/woocommerce.php'
alias na='vi ~/fo/inc/admin.php'
alias nf='vi ~/fo/functions.php'
alias ndevp='vi /var/log/php/tgdev1.transitionsgroup.net-error_log'
alias ndeva='vi /var/log/apache2/tgdev1.transitionsgroup.net-error_log'
