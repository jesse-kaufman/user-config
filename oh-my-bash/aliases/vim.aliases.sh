# shellcheck shell=bash

#
# vim/neovim aliases
#

HOST=$(hostname)

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

if [ "$HOST" == "tgdev1" ]; then
    alias npl='vi /var/log/php/tgdev1.transitionsgroup.net-error_log'
    alias nal='vi /var/log/apache2/tgdev1.transitionsgroup.net-error_log'
    alias npl1='vi /var/log/php/tgdev1.transitionsgroup.net-error_log.1'
    alias nal1='vi /var/log/apache2/tgdev1.transitionsgroup.net-error_log.1'
    alias nala='vi /var/log/apache2/tgdev1.transitionsgroup.net-access_log'
elif [ "$HOST" == "mws1" ]; then
    alias npl='vi /var/log/php/furnitureoptions.com-error_log'
    alias nal='vi /var/log/apache2/furnitureoptions.com-error_log'
    alias npl1='vi /var/log/php/furnitureoptions.com-error_log.1'
    alias nal1='vi /var/log/apache2/furnitureoptions.com-error_log.1'
    alias nala='vi /var/log/apache2/furnitureoptions.com-access_log'
fi
