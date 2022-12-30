#! bash oh-my-bash.module
#  ---------------------------------------------------------------------------

# Directory Listing aliases
alias l='ls'                   # short, sort by default
alias ll='ls -lA'              # long, show all files
alias lr='ls -R'               # short, recursive ls
alias llr='ls -lR'             # long, recursive ls
alias la='ls -A'               # short, show all files
alias lla='ls -lA'             # long, show all files
alias l.='ls -d .*'            # short, only dot files/dirs
alias ll.='ls -ld .*'          # long, only dot files/dirs

alias lm='ls | more'            # short, pipe through 'more'
alias llm='ls -l | more'        # long, pipe through 'more'
alias lam='ls -A | more'        # short, all files, pipe through 'more'
alias llam='ls -lA | more'      # long, all files, pipe through 'more'

alias lc='ls -lcr'              # sort by change time
alias lk='ls -lSr'              # sort by size
alias lh='ls -lSrh'             # sort by size human readable
alias lo='ls -lAS'              # sort by size largest to smallest
alias lt='ls -ltr'              # sort by date
alias lu='ls -lur'              # sort by access time


#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias ltr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

alias dsh='du -sh'                        # Short and human-readable directory listing
