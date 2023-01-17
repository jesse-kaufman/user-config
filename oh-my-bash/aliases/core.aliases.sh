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
alias grep='grep --exclude-dir=".git" --color=auto'
alias grepr='grep -R --exclude-dir=".git"'
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
alias mws='ssh mws1.transitionsgroup.net'

alias tic='tic -sx'
