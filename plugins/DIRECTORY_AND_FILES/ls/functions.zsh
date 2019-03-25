# title           : ls/functions.zsh
# description     : This file provides various functions to the ls command.
# date            : 2019-03-25
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


function _generic_ls() {
    setopt local_options no_null_glob
    setopt local_options no_no_match

    local glob_qualifier="$1"
    shift

    if [[ $# == 0 || ( $# == 1 && $1 == '.' ) ]]; then
        ls -ld *($~glob_qualifier)
    else
        local -a dir_results
        local -a file_results
        local correct_dir=false
        for dir in "$@"; do
            dir=${dir%/}
            local res=""
            if [[ -d $dir ]]; then
                correct_dir=true
                res=$(ls -ld $dir/*($~glob_qualifier) 2>/dev/null)
                if [[ $res =~ "[:space:]" ]]; then
                    dir_results+=( "$dir:"$'\n'"$res" )
                fi
            fi
            if [[ -f $dir ]]; then
                correct_dir=true
                res=$(ls -ld $dir($~glob_qualifier) 2>/dev/null)
                if [[ $res =~ "[:space:]" ]]; then
                    file_results+=( "$res" )
                fi
            fi
        done
        if [[ ${#dir_results} != 0 || ${#file_results} != 0 ]]; then
            if [[ ${#file_results} != 0 ]]; then 
                for res in ${file_results[@]}; do
                    echo "$res"
                done
            fi
            if [[ ${#dir_results} != 0 ]]; then
                if [[ ${#file_results} != 0 ]]; then 
                    echo ''
                fi
                for ((i=1; i<${#dir_results}; i++)); do
                    echo "${dir_results[i]//${dir_results[i]%%:$'\n'*}\//}\n"
                done
                echo "${dir_results[-1]//${dir_results[-1]%%:$'\n'*}\//}"
            fi
        else 
            if [ $correct_dir == true ]; then
                echoerr "$0: No matches found"
            else
                echoerr "$0: No such files or directories"
            fi
        fi
    fi
}


# list all executable files
function lsexec() {
    declare -a args=( '*' "$@" )
    _generic_ls ${args[@]}
}

# list all empty files and directories
function lsempty() {
    declare -a args=( 'L0,/^F' "$@" )
    _generic_ls ${args[@]}
}

# list all files owned by the shell user
function lsmy() {
    declare -a args=( 'U' "$@" )
    _generic_ls ${args[@]}
}

# list all files modified today (since midnight)
function lstoday() {
    integer sec_passed=$(date -d "1970-01-01 UTC $(date +%T)" +%s)
    declare -a args=( "ms-$sec_passed" "$@" )
    _generic_ls ${args[@]}
}