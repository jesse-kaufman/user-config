# shellcheck disable=2207
#shellcheck shell=bash

#
# GLX Oh-My-Bash theme
# An agnoster-inspired (which is a Powerline-inspired) theme for BASH
#

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

my_color() {
    case "$1" in
        black) echo 16\;16\;16 ;;
        dkgray) echo 50\;50\;50 ;;
        red) echo 220\;81\;63 ;;
        ltred) echo 236\;95\;103 ;;
        ltgreen) echo 152\;190\;101 ;;
        dkgreen) echo 21\;113\;8 ;;
        leaf) echo 16\;79\;6 ;;
        purple) echo 113\;88\;192 ;;
        dkpurple) echo 78\;61\;134 ;;
        green) echo 79\;163\;49 ;;
        yellow) echo 254\;203\;47 ;;
        blue) echo 91\;141\;216 ;;
        dkblue) echo 74\;111\;165 ;;
        magenta) echo 174\;80\;185 ;;
        cyan) echo 128\;232\;255 ;;
        white) echo 191\;191\;191 ;;
        ltwhite) echo 245\;245\;245 ;;
        ltgray) echo 130\;130\;130 ;;
        gray) echo 82\;82\;82 ;;
        foreground) echo 187\;194\;207 ;;
        background) echo 42\;45\;50 ;;
        dkbackground) echo 22\;25\;28 ;;
        lavendar) echo 169\;161\;225 ;;
        orange) echo 252\;138\;37 ;;
        dkorange) echo 250\;90\;31 ;;
    esac
}

fg_color() {
    echo -ne "38;2;"
    my_color "$1"
}

bg_color() {
    echo -ne "48;2;"
    my_color "$1"
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

    PR="${PR}\n"

    # shellcheck disable=2034
    declare -a codes=($(fg_color gray))
    PR="${PR}$(ansi codes[@])└─"

    if [[ $RETVAL -ne 0 ]]; then
        symbols="$(ansi_single $(fg_color red)) "
    else
        symbols="$(ansi_single $(fg_color ltgreen)) "
    fi

    jobs=$(jobs -sl | wc -l | xargs)

    if [[ $jobs -gt 0 ]]; then
        symbols="${symbols}$(ansi_single $(fg_color ltgray))${jobs}$(ansi_single $(fg_color gray)) "
    fi

    if [[ -n "$symbols" ]]; then
        PR="${PR}${symbols}"
    fi

    if [[ "$USER" == "root" ]]; then
        PR="${PR}$(ansi_single $(fg_color dkorange))  "
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

    if [[ "$HOST" = "re710" ]]; then
        HOST_BG="dkpurple"
        ICON="$(ansi_single $(fg_color green)) $(ansi_single $(fg_color ltwhite))"
    elif [[ "$HOST" = "re420" ]]; then
        HOST_BG="green"
        ICON="$(ansi_single $(fg_color dkpurple)) $(ansi_single $(fg_color black))"
    elif [[ "$HOST" = "tgdev1" ]]; then
        HOST_BG="lavendar"
        ICON="󰙨 "
    elif [[ "$HOST" = "tgdev2" ]]; then
        HOST_BG="dkpurple"
        ICON="󰙨 "
    elif [[ "$HOST" = "mws1" ]]; then
        HOST_BG="orange"
        ICON=" "
    fi

    declare -a codes=($(fg_color "${HOST_BG}"))
    PR="$PR$(ansi_single $(fg_color "${HOST_BG}"))"

    declare -a codes=($(fg_color background) $(bg_color "${HOST_BG}"))
    # PR="$PR$(ansi_single $(text_effect "bold"))"
    # PR="$PR$(ansi_single $(text_effect "italic"))"
    PR="$PR$(ansi codes[@]) "
    # if [[ "$user" != "$DEFAULT_USER" || -n $SSH_CLIENT ]]; then
    #     PR="$PR$user@"
    # fi
    PR="$PR$ICON$HOST "

    # Reset font style
    PR="$PR$(ansi_single $(text_effect reset))"

    declare -a codes=($(fg_color "${HOST_BG}") $(bg_color "background"))

    PR="$PR$(ansi codes[@])"
}

git_status_dirty() {
    dirty=$(git status -s 2>/dev/null | tail -n 1)
    [[ -n $dirty ]] && echo "󰧞"
}

# Git: branch/detached head, dirty status
prompt_git() {
    local ref dirty
    if [[ $is_git -eq 1 ]]; then
        # Set color and add segment separator.
        declare -a codes=($(fg_color 'background') $(bg_color 'dkbackground'))
        PR="$PR$(ansi codes[@])"

        dirty=$(git_status_dirty)
        ref=$(git symbolic-ref HEAD 2>/dev/null) || ref="➦ $(git show-ref --head -s --abbrev | head -n1 2>/dev/null)"
        declare -a codes=($(fg_color 'gray') $(bg_color 'dkbackground'))
        PR="$PR $(ansi codes[@])${ref/refs\/heads\// } "
        if [[ -n $dirty ]]; then
            declare -a codes=($(fg_color 'orange') $(bg_color 'dkbackground'))
            PR="$PR$(ansi codes[@])$dirty"
        fi

        declare -a reset=($(text_effect reset))
        PR="$PR$(ansi reset[@])"

        declare -a codes=($(fg_color 'dkbackground'))
        PR="$PR$(ansi codes[@])"
    fi
}

# Dir: current working directory
prompt_dir() {
    local path
    path=$PWD
    pwd_length=60 # XXX: update this to calculate based on number of columns in window
    # shellcheck disable=2034
    pwd_symbol=""

    if [[ "$path" != *"$HOME"* ]]; then
        path="󰋜 ${path}"
    else
        path="${path/$HOME/󰋜 }"
    fi

    if [ "$(echo -n "$path" | wc -c | tr -d " ")" -gt $pwd_length ]; then
        path="$(echo -n "$path" | awk -F '/' '{print $1 "/" $2 "/$pwd_symbol/" $(NF-1) "/" $(NF)}')"
    fi

    IFS='/' read -ra path_item <<<"$path"
    for path_item in "${path_item[@]}"; do
        if [[ "$path_item" == "\$pwd_symbol" ]]; then
            prompt_segment background gray "$path_item"
        else
            prompt_segment background foreground "$path_item"
        fi
    done

    PR="${PR} $(ansi_single $(text_effect reset))"

    if [[ $is_git -eq 1 ]]; then
        declare -a codes=($(fg_color 'background') $(bg_color 'dkbackground'))
    else
        declare -a codes=($(fg_color 'background'))
    fi

    PR="${PR}$(ansi codes[@])"
}

######################################################################
## Main prompt

build_prompt() {
    HOST=$(hostname)
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        is_git=1
    else
        is_git=0
    fi

    [[ -z ${AG_NO_CONTEXT+x} ]] && prompt_context
    prompt_virtualenv
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
