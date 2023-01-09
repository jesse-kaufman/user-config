#!/usr/bin/env bash
# oh-my-bash.module
# vim: ft=bash ts=2 sw=2 sts=2

#
# GLX Oh-My-Bash theme
# An agnoster-inspired (which is a Powerline-inspired) theme for BASH
#


HOST=$(hostname)

if [[ "$HOST" = "re420" ]]; then
    HOST_BG="magenta"
    ICON=" "
elif [[ "$HOST" = "re710" ]]; then
    HOST_BG="ltgreen"
    ICON=" "
elif [[ "$HOST" = "tgdev1" ]]; then
    HOST_BG="lavendar"
    ICON="ﭧ "
elif [[ "$HOST" = "mws1" ]]; then
    HOST_BG="orange"
    ICON=" "
fi

######################################################################
DEBUG=0
debug() {
    if [[ ${DEBUG} -ne 0 ]]; then
        echo >&2 -e "$*"
    fi
}

######################################################################
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
# CURRENT_RBG='NONE'
SEGMENT_SEPARATOR=''
# RIGHT_SEPARATOR=''
# LEFT_SUBSEG=''
# RIGHT_SUBSEG=''

text_effect() {
    case "$1" in
    reset) echo 0 ;;
    bold) echo 1 ;;
    italic) echo 3 ;;
    underline) echo 4 ;;
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
# let g:glx_colors_ltgray     = "#828282"
# let g:glx_colors_dkwhite    = "#bfbfbf"
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
    echo -ne "38;2;"
    case "$1" in
    black) echo 16\;16\;16 ;;
    red) echo 239\;67\;53 ;;
    ltred) echo 236\;95\;103;;
    ltgreen) echo 152\;190\;101 ;;
    green) echo 30\;165\;11 ;;
    yellow) echo 254\;203\;47 ;;
    blue) echo 91\;141\;216 ;;
    magenta) echo 174\;80\;185 ;;
    cyan) echo 128\;232\;255 ;;
    white) echo 191\;191\;191 ;;
    ltgray) echo 130\;130\;130 ;;
    gray) echo 82\;82\;82 ;;
    foreground) echo 187\;194\;207 ;;
    background) echo 42\;45\;50 ;;
    lavendar) echo 169\;161\;225 ;;
    orange) echo 252\;138\;37 ;;
    dkorange) echo 250\;90\;31 ;;
    esac
}

bg_color() {
    echo -ne "48;2;"
    case "$1" in
    black) echo 16\;16\;16 ;;
    ltred) echo 236\;95\;103;;
    red) echo 239\;67\;53 ;;
    ltgreen) echo 152\;190\;101 ;;
    green) echo 30\;165\;11 ;;
    yellow) echo 254\;203\;47 ;;
    blue) echo 91\;141\;216 ;;
    magenta) echo 174\;80\;185 ;;
    cyan) echo 128\;232\;255 ;;
    white) echo 191\;191\;191 ;;
    ltgray) echo 130\;130\;130 ;;
    gray) echo 82\;82\;82 ;;
    foreground) echo 187\;194\;207 ;;
    background) echo 42\;45\;50 ;;
    lavendar) echo 169\;161\;225 ;;
    orange) echo 252\;138\;37 ;;
    dkorange) echo 250\;90\;31 ;;
    esac
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

    codes=(${codes[@]} $(text_effect reset))

    if [[ -n $1 ]]; then
        # shellcheck disable=2086
        bg=$(bg_color $1)
        codes=(${codes[@]} $bg)
        debug "Added $bg as background to codes"
    fi
    if [[ -n $2 ]]; then
        # shellcheck disable=2086
        fg=$(fg_color $2)
        codes=(${codes[@]} $fg)
        debug "Added $fg as foreground to codes"
    fi

    PR="$PR$(ansi codes[@]) "
}

# Begin a segment
# Takes three arguments, background, foreground, and content. All can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    declare -a codes

    debug "Prompting $1 $2 $3"

    # shellcheck disable=2207
    codes=("${codes[@]}" $(text_effect reset))

    if [[ -n $1 ]]; then
        # shellcheck disable=2086
        bg=$(bg_color $1)
        # shellcheck disable=2206
        codes=("${codes[@]}" $bg)
        debug "Added $bg as background to codes"
    fi
    if [[ -n $2 ]]; then
        # shellcheck disable=2086
        fg=$(fg_color $2)
        # shellcheck disable=2206
        codes=("${codes[@]}" $fg)
        debug "Added $fg as foreground to codes"
    fi

    debug "Codes: "
    # declare -p codes

    if [[ $CURRENT_BG != NONE && $1 != "$CURRENT_BG" ]]; then
        # shellcheck disable=2034
        declare -a intermediate=($(fg_color gray) $(bg_color background))
        debug "pre prompt " "$(ansi intermediate[@])"
        PR="$PR $(ansi intermediate[@])$SEGMENT_SEPARATOR"
        debug "post prompt " "$(ansi codes[@])"
        PR="$PR$(ansi codes[@]) "
    else
        # shellcheck disable=2145
        debug "no current BG, codes is ${codes[@]}"
        PR="$PR$(ansi codes[@]) "
    fi
    CURRENT_BG=$(bg_color background)
    [[ -n $3 ]] && PR="$PR$3"
}

# End the prompt, closing any open segments
prompt_end() {
    local symbols

    # shellcheck disable=2034
    declare -a reset=($(text_effect reset))
    PR="$PR $(ansi reset[@])"

    # shellcheck disable=2034
    declare -a codes=($(fg_color background))
    PR="$PR$(ansi codes[@])"

    PR="${PR}\n"

    # shellcheck disable=2034
    declare -a codes=($(fg_color gray))
    PR="${PR}$(ansi codes[@])└─"

    if [[ $RETVAL -ne 0 ]]; then
        symbols="$(ansi_single $(fg_color yellow))⚡"
    else
        symbols="$(ansi_single $(fg_color ltgreen))⚡"
    fi

    jobs=$(jobs -sl | wc -l | xargs)

    if [[ $jobs -gt 0 ]]; then
        symbols="${symbols}$(ansi_single $(fg_color ltgray))${jobs}$(ansi_single $(fg_color gray)) "
    fi

    if [[ -n "$symbols" ]]; then
        PR="${PR}${symbols}"
    fi


    if [[ "$USER" == "root" ]]; then
        PR="${PR}$(ansi_single $(fg_color dkorange)) "
    else
        PR="${PR}$(ansi reset[@]) "
    fi

    PR="${PR}$(ansi reset[@])"
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

    # shellcheck disable=2046
    PR="\n$(ansi_single $(text_effect reset))"
    PR="$PR$(ansi_single $(fg_color gray))┌"

    declare -a codes=($(fg_color "${HOST_BG}"))
    PR="$PR$(ansi_single $(fg_color "${HOST_BG}"))"

    declare -a codes=($(fg_color background) $(bg_color "${HOST_BG}"))
    PR="$PR$(ansi_single $(text_effect "bold"))"
    # PR="$PR$(ansi_single $(text_effect "italic"))"
    PR="$PR$(ansi codes[@]) "
    # if [[ "$user" != "$DEFAULT_USER" || -n $SSH_CLIENT ]]; then
    #     PR="$PR$user@"
    # fi
    PR="$PR$ICON\h "

    # Reset font style
    PR="$PR$(ansi_single $(text_effect reset))"

    declare -a codes=($(fg_color "${HOST_BG}") $(bg_color "background"))

    PR="$PR$(ansi codes[@])"
}

# prints history followed by HH:MM, useful for remembering what
# we did previously
prompt_histdt() {
    prompt_segment background default "\! [\A]"
}

git_status_dirty() {
    dirty=$(git status -s 2>/dev/null | tail -n 1)
    [[ -n $dirty ]] && echo ""
}

# Git: branch/detached head, dirty status
prompt_git() {
    local ref dirty
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        dirty=$(git_status_dirty)
        ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="➦ $(git show-ref --head -s --abbrev | head -n1 2>/dev/null)"
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
    local path
    pwd_length=60
    # shellcheck disable=2034
    pwd_symbol=""

    path="${PWD/$HOME/}"
    if [ "$(echo -n "$path" | wc -c | tr -d " ")" -gt $pwd_length ]
    then
        path="$(echo -n "$path" | awk -F '/' '{print $1 "/" $2 "/$pwd_symbol/" $(NF-1) "/" $(NF)}')"
    fi

    IFS='/' read -ra path_item <<< "$path"
    for path_item in "${path_item[@]}"; do
        # shellcheck disable=2016
        if [[ "$path_item" == '$pwd_symbol' ]]; then
            prompt_segment background gray "$path_item"
        else
            prompt_segment background foreground "$path_item"
        fi
    done
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="$(ansi_single "$(fg_color red)")✘"
    [[ $UID -eq 0 ]] && symbols+="$(ansi_single "$(fg_color yellow)")⚡"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="$(ansi_single "$(fg_color cyan)")⚙"

    [[ -n "$symbols" ]] && symbols+="$(ansi_single "$(bg_color background)")"

    [[ -n "$symbols" ]] && prompt_segment background default "$symbols"
}


######################################################################
## Main prompt

build_prompt() {
    #[[ -z ${AG_NO_HIST+x} ]] && prompt_histdt
    [[ -z ${AG_NO_CONTEXT+x} ]] && prompt_context
    prompt_virtualenv
    # prompt_status
    prompt_dir
    prompt_git
    prompt_end
}

_omb_theme_PROMPT_COMMAND() {
    RETVAL=$?
    PR=""
    PRIGHT=""
    CURRENT_BG=NONE
    # shellcheck disable=2046
    PR="\n$(ansi_single $(text_effect reset))"
    build_prompt

    PS1=$PR
}
_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
