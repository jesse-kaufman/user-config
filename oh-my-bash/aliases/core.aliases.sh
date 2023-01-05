# shellcheck shell=bash

# Core aliases
#

alias cdp='cd ~/plugins/'
alias cdf='cd ~/fo/'
alias cdi='cd ~/fo/inc/'
alias c='cd'
alias grep='grep --exclude-dir=".git"'
alias grepr='grep -R --exclude-dir=".git"'
alias grepv='grep -v'
alias taildevp='tail -f /var/log/php/tgdev1.transitionsgroup.net-error_log'
alias taildeva='tail -f /var/log/apache2/tgdev1.transitionsgroup.net-error_log'
alias pw='pwd'
alias cmp='composer'

alias diff='diff --color=always'

alias less='less -FRXc'

if command -v editorconfig-checker &>/dev/null; then
    alias ec='editorconfig-checker'
elif command -v ec &>/dev/null; then
    alias editorconfig-checker='ec'
fi

alias dev='ssh tgdev1.transitionsgroup.net'
alias mws='ssh mws1.transitionsgroup.net'
