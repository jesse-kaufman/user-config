# shellcheck shell=bash

# Core aliases
#
alias sudo='sudo '
alias cdp='cd ~/plugins/'
alias cdf='cd ~/fo/'
alias cdi='cd ~/fo/inc/'
alias c='cd'
unalias mv
alias mv='mv -i'
alias grep="grep --exclude-dir={.git,'*node_modules*'} --exclude=.phpcs.cache --color=auto"
alias grepr="grep -R --exclude-dir={.git,'*node_modules*'} --exclude=.phpcs.cache"
alias grepv='grep -v'
alias taildevp='tail -f /var/log/php/tgdev1.transitionsgroup.net-error_log'
alias taildeva='tail -f /var/log/apache2/tgdev1.transitionsgroup.net-error_log'
alias pw='pwd'
alias cmp='composer'

alias diff='diff --color=always'

alias less='less -FRXc'

colortail="$(which multitail)"

if [[ "${colortail}X" != "X" ]]; then
    alias ctail="colortail -k \$HOME/.config/colortail/default.conf"
else
    alias ctail='tail'
fi

if command -v editorconfig-checker &>/dev/null; then
    alias ec='editorconfig-checker'
elif command -v ec &>/dev/null; then
    alias editorconfig-checker='ec'
fi

alias dev='ssh tgdev1.transitionsgroup.net'
alias dev2='ssh jkaufman@4.236.163.23'
alias mws='ssh mws1.transitionsgroup.net'

alias tic='tic -sx'
