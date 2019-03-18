#!/bin/bash

# ==== change directory (cd) ====
if [ -n "$ZSH_VERSION" ]; then              ## global aliases only defined in ZSH
    alias -g ...='../..'                    # move two directories up
    alias -g ....='../../..'                # move three directories up
    alias -g .....='../../../..'            # move four directories up
    alias -g ......='../../../../..'        # move five directories up
fi


local warp_file_dir="$( cd "$(dirname "$0")" ; pwd -P )/.warp_points"
if ! file_exists $warp_file_dir ; then
    touch $warp_file_dir
fi


# colors
CD_ERROR='\e[38;5;160m'
CD_INFO='\e[38;5;245m'
CD_RESET='\e[0m'


function cd_error() {
    echo -e "${CD_ERROR}$@${CD_RESET}" 1>&2;
}
function cd_info() {
    echo -e "${CD_INFO}$@${CD_RESET}"
}


function warp_add() {
    local warp_point_exists=$(sed -n "/^$2=/p" $warp_file_dir)      ## check whether the given warp point name already exists
    if [ -z $warp_point_exists ]; then
        sed -i "$ a $2=$PWD" $warp_file_dir                         ## append new warp point after the last line
        cd_info "warp point added: $2 → $PWD"
    else 
        cd_error "warp point $2 already added (use --warp-add! to override)"
        return 1
    fi
}
function warp_force_add() {
    local warp_point_exists=$(sed -n "/^$2=/p" $warp_file_dir)      ## check whether the given warp point name already exists
    if [ -z $warp_point_exists ]; then
        sed -i "$ a $2=$PWD" $warp_file_dir                         ## append new warp point after the last line
        cd_info "warp point added: $2 → $PWD"
    else 
        sed -i "/^$2=/d" $warp_file_dir                             ## remove old warp point if neccessary
        sed -i "$ a $2=$PWD" $warp_file_dir                         ## append updated warp point after the last line
        cd_info "replaced warp point: $2: ${old_warp_dir#*=} ⇒ $PWD"
    fi
}
function warp_remove() {
    local warp_point_exists=$(sed -n "/^$2=/p" $warp_file_dir)      ## check whether the given warp point name exists
    if [ -n $warp_point_exists ]; then 
        sed -i "/^$2=/d" $warp_file_dir                             ## remove warp point
        cd_info "warp point removed: ${warp_point_exists/=/ → }"
    else 
        echoerr "warp point $2 doesn't exist (use --warp-list to list all available warp points)"
    fi
}
function warp_list() {
    sed 's/=/ → /g' $warp_file_dir
}
function warp_clean() {
    while IFS='' read -r line || [[ -n "$line" ]]; do               ## loop over all warp points
        if [ ! -d "${line#*=}" ]; then                              ## check whether warp point directory still exists
            sed -i "\|$line|d" $warp_file_dir                       ## remove warp point if directory is now invalid
            cd_info "removed invalid warp point ${line/=/ → }"
        fi
    done < "$warp_file_dir"
}

function ccd() {                            # cd with the option to jump back to a given directory in the current working directory
    case $1 in 
        '--warp-add'|'-a')
            warp_add "$@"                   ## add new warp point if there is no existing warp point with the current name
        ;;
        '--warp-add!'|'-a!')
            warp_force_add "$@"             ## add a new warp point or replace an already existing one
        ;;
        '--warp-remove'|'-rm')
            warp_remove "$@"                ## remove the given warp point if possible
        ;;
        '--warp-list'|'-l')
            warp_list "$@"                  ## list all warp points
        ;;
        '--warp-clean'|'-c')
            warp_clean "$@"                 ## remove all invalid warp points
        ;;
        '--warp-help'|'-h')
            echo "TODO: help infos"
        ;;
        *)
            local next_dir=$1
            builtin cd $next_dir >/dev/null 2>&1        ## try to cd
            if [[ $? != 0 ]]; then                      ## try to jump back if cd failed
                if [[ ${next_dir: -1} == '/' ]]; then   ## delete trailing "/" if present
                    next_dir=${next_dir: : -1}
                fi
                if [[ $PWD == *$next_dir* ]]; then      ## check if you can jump to the specific directory
                    local new_dir=$(pwd | nawk -F "/$next_dir/" '{print $1}')
                    builtin cd $new_dir'/'$next_dir
                else                                    ## try to cd to warp point
                    local warp_point_exists=$(sed -n "/^$1=/p" $warp_file_dir)
                    if [ -n $warp_point_exists ]; then
                        builtin cd ${warp_point_exists#*=}
                    else                                    ## illegal cd
                        echo "cd: no such file or directory: $next_dir"
                    fi
                fi
            fi
        ;;
    esac
}
