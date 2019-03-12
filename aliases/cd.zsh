#!/bin/bash

declare -A CD_WARP_POINTS

local warp_file_dir="$( cd "$(dirname "$0")" ; pwd -P )/.warp_points"
if ! file_exists $warp_file_dir ; then
    touch $warp_file_dir
else
    while IFS='' read -r line || [[ -n "$line" ]]; do
        CD_WARP_POINTS[${line%%=*}]=${line#*=}
    done < "$warp_file_dir"
fi


function ccd() {                            # cd with the option to jump back to a given directory in the current working directory
    
    case $1 in 
        "--warp-add")
            if ! [ ${CD_WARP_POINTS[$2]+_} ]; then 
                CD_WARP_POINTS[$2]=$PWD
                echo "$2=$PWD" >> $warp_file_dir
                echo "cd: warp point added: $2 -> $PWD"
            else 
                echoerr "cd: warp point $2 already added (use --warp-add! to override)"
            fi
        ;;
        "--warp-add!")
            sed -i "/$2=/d" $warp_file_dir
            CD_WARP_POINTS[$2]=$PWD
            echo "$2=$PWD" >> $warp_file_dir
            echo "cd: warp point added: $2 -> $PWD"
        ;;
        "--warp-remove")
            if [ ${CD_WARP_POINTS[$2]+_} ]; then 
                sed -i "/$2=/d" $warp_file_dir
                unset CD_WARP_POINTS[$2]
                echo "cd: warp point removed: $2"
            else 
                echoerr "cd: warp point $2 doesn't exist (use --warp-list to list all available warp points"
            fi
        ;;
        "--warp-list")
            for i in "${(k)CD_WARP_POINTS[@]}"; do
                echo "$i -> ${CD_WARP_POINTS[$i]}"
            done
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
                elif [ ${CD_WARP_POINTS[$1]+_} ]; then  ## cd to warp point
                    builtin cd ${CD_WARP_POINTS[$1]}
                else                                    ## illegal cd
                    echo "cd: no such file or directory: $next_dir"
                fi
            fi
        ;;
    esac
}