# title           : warp/functions.zsh
# description     : This file provides a function to directly cd to directories and helper functions to achiev this.
# date            : 2019-03-30
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# easily read all lines of a file into an array
zmodload zsh/mapfile

# if not existing: create new warp_file to store existing warp_points
local _warp_file_dir="$( cd "$(dirname "$0")" ; pwd -P )/.warp_points"
if ! file_exists $_warp_file_dir ; then
    touch $_warp_file_dir
fi


# check whether the warp point name is legal
function _warp_check_illegal_name() {
    if [[ $1 =~ '^[A-Za-z0-9_-]*$' ]]; then
        return 0
    else
        echoerr "warp: illegal name: $1 (correct: [A-Za-z0-9_-])"
        return 22
    fi
}

# check whether the given number of parameters is correct
function _warp_check_parameter_count() {
    if [[ $1 == $2 ]]; then
        ## correct number of parameters
        return 0
    else
        ## incorrect number of parameters
        echoerr "warp: illegal number of parameters: expected $1, provided $2"
        return 7
    fi
}

# check whether the given path is an absolute directory
function _warp_check_absolute_path() {
    if [[ -d "$1" && "$1" == /* ]]; then
        ## is absolute directory"
        return 0
    else
        ## no directory or not absolute
        echoerr "warp: not a (absolute) directory: $1"
        return 20
    fi
}


# add a new warp point if the name isn't taken yet and if it is a directory
function _warp_add() {
    local warp_point_exists=$(sed -n "/^$1=/p" $_warp_file_dir)
    ## check whether the given warp point name already exists
    if [[ -z $warp_point_exists ]]; then
        ## append new warp point after the last line
        echo "$1=$2" >> $_warp_file_dir
        echo "warp point added: $1 → $2"
    else
        echoerr "warp: $1 already added (use -! or --add! to override)"
        return 17
    fi
}

# add a new warp point or replace an already existing one
function _warp_force_add() {
    local warp_point_exists=$(sed -n "/^$1=/p" $_warp_file_dir)
    ## check whether the given warp point name already exists
    if [[ -z $warp_point_exists ]]; then
        ## append new warp point after the last line
        echo "$1=$2" >> $_warp_file_dir
        echo "warp point added: $1 → $2"
    else
        ## remove old warp point if neccessary
        sed -i "/^$1=/d" $_warp_file_dir
        ## append updated warp point after the last line
        echo "$1=$2" >> $_warp_file_dir
        echo "replaced warp point: $1: ${old_warp_dir#*=} ⇒ $2"
    fi
}

# remove the given warp point (if possible)
function _warp_remove() {
    local warp_point_exists=$(sed -n "/^$1=/p" $_warp_file_dir)
    ## check whether the given warp point name exists
    if [[ -n $warp_point_exists ]]; then
       ## remove warp point
       sed -i "/^$1=/d" $_warp_file_dir
       echo "warp point removed: ${warp_point_exists/=/ → }"
    else
       echoerr "warp: $1 doesn't exist (use -l or --list to list all available warp points)"
       return 2
    fi
}

# remove all invalid warp points
function _warp_clean() {
    ## loop over all warp points
    for line in "${(f)mapfile[$_warp_file_dir]}"; do
        ## don't try to clean an empty line
        [[ ! $line =~ '[:space:]+' ]] && continue
        ## check whether warp point directory still exists
        if ! [[ -d "${line#*=}" ]]; then
            ## remove warp point if directory is now invalid
            sed -i "\|$line|d" $_warp_file_dir
            echo "removed invalid warp point: ${line/=/ → }"
        fi
    done
}

# list all warp points
function _warp_list() {
    sed 's/=/ → /g' $_warp_file_dir
}

# display help option
function _warp_help() {
    cat <<- EOF
Usage: warp [option] [warp point name] [warp point target]
Options:
    -a,  --add        add a new warp point to the given directory with the specified name
    -!,  --add!       add a new warp point to the given directory with the specified name
                      overrides existing warp point if necessary
    -rm, --remove     removes an existing warp point
    -c,  --clean      remove all unused warp points
    -l,  --list       lists all warp points
    -h,  --help       display help message
Return Codes:
    1       illegal option
    2       warp point doesn't exist
    7       illegal number of parameters
    17      warp point already exists
    20      illegal warp point target path (not an absolute directory)
    22      illegal warp point name
EOF
}

# try to warp
function _warp_to_point() {
  local warp_point_exists=$(sed -n "/^$1=/p" $_warp_file_dir)
  ## check whether the given warp point name exists
  if [[ -n $warp_point_exists ]]; then
    ## try to change to the directory saved in the given warp point
    builtin cd "${warp_point_exists#*=}" >/dev/null 2>&1
    ## warp point target doesn't exist anymore
    if [[ $? != 0 ]]; then
      echoerr "warp: no such directory: ${warp_point_exists#*=}"
    fi
  else
    ## no warp point was given
    echoerr "warp: not a warp point: $1"
  fi
}


# function to create warp points (for easier cd'ing)
function warp() {
    ## stop if no options where given
    if [[ $# == 0 ]]; then
        echoerr "$0: no parameter"
        return 1
    fi

    ## get user option and remove it from the positional parameters
    local option=$1
    shift

    case $option in
        ('--add'|'-a')
            ## if no directory is given use current working directory
            if [[ $# == 1 ]]; then
                set $1 $PWD
            fi
            ## add a new warp point if the name isn't taken yet
            _warp_check_parameter_count 2 $# && \
            _warp_check_illegal_name $1 && \
            _warp_check_absolute_path "$2" && \
            _warp_add "$@"
        ;;
        ('--add!'|'-!')
            ## if no directory is given use current working directory
            if [[ $# == 1 ]]; then
                set $1 $PWD
            fi
            ## add a new warp point or replace an already existing one
            _warp_check_parameter_count 2 $# && \
            _warp_check_illegal_name $1 && \
            _warp_check_absolute_path "$2" && \
            _warp_force_add "$@"
        ;;
        ('--remove'|'-rm')
            ## remove the given warp point (if possible)
            _warp_check_parameter_count 1 $# && \
            _warp_check_illegal_name $1 && \
            _warp_remove "$@"
        ;;
        ('--clean'|'-c')
            ## remove all invalid warp points
            _warp_check_parameter_count 0 $# && _warp_clean "$@"
        ;;
        ('--list'|'-l')
            ## list all warp points
            _warp_check_parameter_count 0 $# && _warp_list "$@"
        ;;
        ('--help'|'-h')
            ## display help information
            _warp_check_parameter_count 0 $# && _warp_help "$@"
        ;;
        (*)
            ## try to cd to the given warp point target
            _warp_check_parameter_count 0 $# && _warp_to_point "$option"
        ;;
    esac
}
