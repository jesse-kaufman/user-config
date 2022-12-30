#! bash oh-my-bash.module
# vim: ft=bash ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for BASH
#
# (Converted from ZSH theme by Kenny Root)
# https://gist.github.com/kruton/8345450
#
# Updated & fixed by Erik Selberg erik@selberg.org 1/14/17
# Tested on MacOSX, Ubuntu, Amazon Linux
# Bash v3 and v4
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
# I recommend: https://github.com/powerline/fonts.git
# > git clone https://github.com/powerline/fonts.git fonts
# > cd fonts
# > install.sh

# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.

# Install:

# I recommend the following:
# $ cd home
# $ mkdir -p .bash/themes/agnoster-bash
# $ git clone https://github.com/speedenator/agnoster-bash.git .bash/themes/agnoster-bash

export DEFAULT_USER=$(whoami)

HOST=`hostname`

if [[ "$HOST" -eq "re420" ]]; then
    HOST_BG="ltgreen"
fi

#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

# Generally speaking, this script has limited support for right
# prompts (ala powerlevel9k on zsh), but it's pretty problematic in Bash.
# The general pattern is to write out the right prompt, hit \r, then
# write the left. This is problematic for the following reasons:
# - Doesn't properly resize dynamically when you resize the terminal
# - Changes to the prompt (like clearing and re-typing, super common) deletes the prompt
# - Getting the right alignment via columns / tput cols is pretty problematic (and is a bug in this version)
# - Bash prompt escapes (like \h or \w) don't get interpolated
#
# all in all, if you really, really want right-side prompts without a
# ton of work, recommend going to zsh for now. If you know how to fix this,
# would appreciate it!

# note: requires bash v4+... Mac users - you often have bash3.
# 'brew install bash' will set you free
PROMPT_DIRTRIM=2 # bash4 and above

######################################################################
DEBUG=0
debug() {
    if [[ ${DEBUG} -ne 0 ]]; then
        >&2 echo -e $*
    fi
}

######################################################################
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
CURRENT_RBG='NONE'
SEGMENT_SEPARATOR=''
RIGHT_SEPARATOR=''
LEFT_SUBSEG=''
RIGHT_SUBSEG=''

text_effect() {
    case "$1" in
        reset)      echo 0;;
        bold)       echo 1;;
        underline)  echo 4;;
    esac
}

# to add colors, see
# http://bitmote.com/index.php?post/2012/11/19/Using-ANSI-Color-Codes-to-Colorize-Your-Bash-Prompt-on-Linux
# under the "256 (8-bit) Colors" section, and follow the example for orange below
#
# let g:glx_colors_black      = "#101010"
# let g:glx_colors_ltblack    = "#262626"
# let g:glx_colors_dkgray     = "#323232"
# let g:glx_colors_gray       = "#525252"
# let g:glx_colors_ltgray     = "#bfbfbf"
# let g:glx_colors_white      = "#eaeaea"
# let g:glx_colors_teal       = "#008080"
# let g:glx_colors_ltcyan     = "#80e8ff"
# let g:glx_colors_cyan       = "#56bbdc"
# let g:glx_colors_ltblue     = "#5b8dd8"
# let g:glx_colors_blue       = "#3879d8"
# let g:glx_colors_dkblue     = "#4a6fa5"
# let g:glx_colors_lavendar   = "#a9a1e1"
# let g:glx_colors_magenta    = "#c678dd"
# let g:glx_colors_ltred      = "#ec5f67"
# let g:glx_colors_red        = "#ef4335"
# let g:glx_colors_dkorange   = "#fa5a1f"
# let g:glx_colors_orange     = "#fc8a25"
# let g:glx_colors_yellow     = "#fecb2f"
# let g:glx_colors_green      = "#98be65"
# let g:glx_colors_ltgreen    = "#1ea50b"
# let g:glx_colors_lualine_bg = "#202328"
# let g:glx_colors_lualine_fg = "#bbc2cf"
fg_color() {
    echo "38;2";
    case "$1" in
        black)      echo 16\;16\;16;;
        red)        echo 239\;67\;53;;
        ltgreen)    echo 152\;190\;101;;
        green)      echo 30\;165\;11;;
        yellow)     echo 254\;203\;47;;
        blue)       echo 91\;141\;216;;
        magenta)    echo 174\;80\;185;;
        cyan)       echo 128\;232\;255;;
        white)      echo 191\;191\;191;;
        gray)       echo 82\;82\;82;;
        foreground) echo 187\;194\;207;;
        background) echo 32\;35\;40;;
        lavendar)   echo 169\;161\;225;;
        orange)     echo 252\;138\;37;;
    esac
}

bg_color() {
    echo "48;2";
    case "$1" in
        black)      echo 16\;16\;16;;
        red)        echo 239\;67\;53;;
        ltgreen)    echo 152\;190\;101;;
        green)      echo 30\;165\;11;;
        yellow)     echo 254\;203\;47;;
        blue)       echo 91\;141\;216;;
        magenta)    echo 174\;80\;185;;
        cyan)       echo 128\;232\;255;;
        white)      echo 191\;191\;191;;
        gray)       echo 82\;82\;82;;
        foreground) echo 187\;194\;207;;
        background) echo 32\;35\;40;;
        lavendar)   echo 169\;161\;225;;
        orange)     echo 252\;138\;37;;
    esac;
}

# TIL: declare is global not local, so best use a different name
# for codes (mycodes) as otherwise it'll clobber the original.
# this changes from BASH v3 to BASH v4.
ansi() {
    local seq
    declare -a mycodes=("${!1}")

    debug "ansi: ${!1} all: $* aka ${mycodes[@]}"

    seq=""
    for ((i = 0; i < ${#mycodes[@]}; i++)); do
        if [[ -n $seq ]]; then
            seq="${seq};"
        fi
        seq="${seq}${mycodes[$i]}"
    done
    debug "ansi debug:" '\\[\\x1b['${seq}'m\\]'
    echo -ne '\[\x1b['${seq}'m\]'
}

ansi_single() {
    echo -ne '\[\x1b['$1'm\]'
}

set_colors() {
    local bg fg
    declare -a codes

    codes=("${codes[@]}" $(text_effect reset))

    if [[ -n $1 ]]; then
        bg=$(bg_color $1)
        codes=("${codes[@]}" $bg)
        debug "Added $bg as background to codes"
    fi
    if [[ -n $2 ]]; then
        fg=$(fg_color $2)
        codes=("${codes[@]}" $fg)
        debug "Added $fg as foreground to codes"
    fi

    PR="$PR$(ansi codes[@]) "
}

# Begin a segment
# Takes three arguments, background, foreground, and content. All can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg separator
    declare -a codes

    debug "Prompting $1 $2 $3"

    codes=("${codes[@]}" $(text_effect reset))

    if [[ -n $1 ]]; then
        bg=$(bg_color $1)
        codes=("${codes[@]}" $bg)
        debug "Added $bg as background to codes"
    fi
    if [[ -n $2 ]]; then
        fg=$(fg_color $2)
        codes=("${codes[@]}" $fg)
        debug "Added $fg as foreground to codes"
    fi

    debug "Codes: "
    # declare -p codes

    if [[ $CURRENT_BG != NONE && $1 != $CURRENT_BG ]]; then
        # declare -a intermediate=($(fg_color $CURRENT_BG) $(bg_color $1))
        declare -a intermediate=($(fg_color gray) $(bg_color background))
        debug "pre prompt " $(ansi intermediate[@])
        PR="$PR $(ansi intermediate[@])$SEGMENT_SEPARATOR"
        debug "post prompt " $(ansi codes[@])
        PR="$PR$(ansi codes[@]) "
    else
        debug "no current BG, codes is $codes[@]"
        PR="$PR$(ansi codes[@]) "
    fi
    CURRENT_BG=$(bg_color background)
    [[ -n $3 ]] && PR="$PR$3"
}

# End the prompt, closing any open segments
prompt_end() {
    declare -a reset=($(text_effect reset))
    PR="$PR $(ansi reset[@])"

    declare -a codes=($(fg_color background))
    PR="$PR$(ansi codes[@])"

    PR="${PR}\n"

    declare -a codes=($(fg_color "${HOST_BG}"))
    PR="$PR$(ansi codes[@])"

    PR="${PR}└─$(ansi reset[@])"
    CURRENT_BG=''
}

### virtualenv prompt
prompt_virtualenv() {
    if [[ -n $VIRTUAL_ENV ]]; then
        # Python could output the version information in both stdout and
        # stderr (e.g. if using pyenv, the output goes to stderr).
        VERSION_OUTPUT=$($VIRTUAL_ENV/bin/python --version 2>&1)

        # The last word of the output of `python --version`
        # corresponds to the version number.
        VENV_VERSION=$(echo $VERSION_OUTPUT | awk '{print $NF}')

        color=cyan
        prompt_segment $color foreground
        prompt_segment $color foreground "$(basename $VENV_VERSION)"
    fi
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
    local user=$(whoami)

    declare -a codes=($(fg_color "${HOST_BG}"))
    PR="$PR$(ansi codes[@])┌"

    declare -a codes=($(fg_color background) $(bg_color "${HOST_BG}"))
    PR="$PR$(ansi codes[@]) "
    if [[ $user != $DEFAULT_USER || -n $SSH_CLIENT ]]; then
        PR="$PR$user@"
    fi
    PR="$PR\h "

    declare -a codes=($(fg_color "${HOST_BG}") $(bg_color background))
    PR="$PR$(ansi codes[@])"
}

# prints history followed by HH:MM, useful for remembering what
# we did previously
prompt_histdt() {
    prompt_segment background default "\! [\A]"
}


git_status_dirty() {
    dirty=$(git status -s 2> /dev/null | tail -n 1)
    [[ -n $dirty ]] && echo ""
}

# Git: branch/detached head, dirty status
prompt_git() {
    local ref dirty
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        ZSH_THEME_GIT_PROMPT_DIRTY='±'
        dirty=$(git_status_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
        prompt_segment background lavendar
        PR="$PR${ref/refs\/heads\// }"
        if [[ -n $dirty ]]; then
            set_colors background orange
            PR="$PR$dirty"
        fi
    fi
}

# Dir: current working directory
prompt_dir() {
    prompt_segment background blue '\w'
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="$(ansi_single $(fg_color red))✘"
    [[ $UID -eq 0 ]] && symbols+="$(ansi_single $(fg_color yellow))⚡"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="$(ansi_single $(fg_color cyan))⚙"

    [[ -n "$symbols" ]] && symbols+="$(ansi_single $(bg_color background))"

    [[ -n "$symbols" ]] && prompt_segment background default "$symbols"
}

######################################################################
#
# experimental right prompt stuff
# requires setting prompt_foo to use PRIGHT vs PR
# doesn't quite work per above

rightprompt() {
    printf "%*s" $COLUMNS "$PRIGHT"
}

# quick right prompt I grabbed to test things.
__command_rprompt() {
    local times= n=$COLUMNS tz
    for tz in ZRH:Europe/Zurich PIT:US/Eastern \
              MTV:US/Pacific TOK:Asia/Tokyo; do
        [ $n -gt 40 ] || break
        times="$times ${tz%%:*}\e[30;1m:\e[0;36;1m"
        times="$times$(TZ=${tz#*:} date +%H:%M)\e[0m"
        n=$(( $n - 10 ))
    done
    [ -z "$times" ] || printf "%${n}s$times\\r" ''
}
# _omb_util_add_prompt_command __command_rprompt

# this doens't wrap code in \[ \]
ansi_r() {
    local seq
    declare -a mycodes2=("${!1}")

    debug "ansi: ${!1} all: $* aka ${mycodes2[@]}"

    seq=""
    for ((i = 0; i < ${#mycodes2[@]}; i++)); do
        if [[ -n $seq ]]; then
            seq="${seq};"
        fi
        seq="${seq}${mycodes2[$i]}"
    done
    debug "ansi debug:" '\\[\\x1b['${seq}'m\\]'
    echo -ne '\x1b['${seq}'m'
}

# Begin a segment on the right
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_right_segment() {
    local bg fg
    declare -a codes

    debug "Prompt right"
    debug "Prompting $1 $2 $3"

    codes=("${codes[@]}" $(text_effect reset))
    if [[ -n $1 ]]; then
        bg=$(bg_color $1)
        codes=("${codes[@]}" $bg)
        debug "Added $bg as background to codes"
    fi
    if [[ -n $2 ]]; then
        fg=$(fg_color $2)
        codes=("${codes[@]}" $fg)
        debug "Added $fg as foreground to codes"
    fi

    debug "Right Codes: "
    declare -a intermediate2=($(fg_color $1) $(bg_color background) )
    debug "pre prompt " $(ansi_r intermediate2[@])
    PRIGHT="$PRIGHT$(ansi_r intermediate2[@])$RIGHT_SEPARATOR"
    debug "post prompt " $(ansi_r codes[@])
    PRIGHT="$PRIGHT$(ansi_r codes[@]) "
    CURRENT_RBG=$1
    [[ -n $3 ]] && PRIGHT="$PRIGHT$3"
}


######################################################################
## Main prompt

build_prompt() {
    #[[ -z ${AG_NO_HIST+x} ]] && prompt_histdt
    [[ -z ${AG_NO_CONTEXT+x} ]] && prompt_context
    prompt_virtualenv
    prompt_status
    prompt_dir
    prompt_git
    prompt_end
}


_omb_theme_PROMPT_COMMAND() {
    RETVAL=$?
    PR=""
    PRIGHT=""
    CURRENT_BG=NONE
    PR="\n$(ansi_single $(text_effect reset))"
    build_prompt

    # uncomment below to use right prompt
    #     PS1='\[$(tput sc; printf "%*s" $COLUMNS "$PRIGHT"; tput rc)\]'$PR
    PS1=$PR
}
_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
