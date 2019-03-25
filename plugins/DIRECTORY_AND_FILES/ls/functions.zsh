# title           : ls/functions.zsh
# description     : This file provides various functions to the ls command.
# date            : 2019-03-25
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# generic function for ls usage with zsh's glob qualifiers
function _generic_ls() {
    ## unset unnecessary options locally
    setopt local_options no_null_glob       ## don't silently remove non matching results
    setopt local_options no_no_match        ## don't print an error message if file or directory doesn't exist

    ## get glob qualifier and remove it from positional arguments list
    local glob_qualifier="$1"
    shift

    ## list current directory iff no parameters was given or just a single dot
    if [[ $# == 0 || ( $# == 1 && $1 == '.' ) ]]; then
        ls -ld *($~glob_qualifier)
    else
        local -a dir_results
        local -a file_results
        local correct_dir=false

        ## for each given file or directory
        for param in "$@"; do
            ## remove trailing / if necessary
            dir=${dir%/}
            local res=""
            
            ## if the current parameter is a directory: add it's name und contents to the result array
            if [[ -d $param ]]; then
                correct_dir=true
                res=$(ls -ld $param/*($~glob_qualifier) 2>/dev/null)
                if [[ $res =~ "[:space:]" ]]; then
                    dir_results+=( "$param:"$'\n'"$res" )
                fi
            fi
            ## if the current parameter is a file: only add it's content to the result array
            if [[ -f $param ]]; then
                correct_dir=true
                res=$(ls -ld $param($~glob_qualifier) 2>/dev/null)
                if [[ $res =~ "[:space:]" ]]; then
                    file_results+=( "$res" )
                fi
            fi
        done

        ## if at least one match was found
        if [[ ${#dir_results} != 0 || ${#file_results} != 0 ]]; then
            ## output all matched files first
            if [[ ${#file_results} != 0 ]]; then 
                for res in ${file_results[@]}; do
                    echo "$res"
                done
            fi
            ## output all matched directories second
            if [[ ${#dir_results} != 0 ]]; then
                ## add a separating newline if necessary
                if [[ ${#file_results} != 0 ]]; then 
                    echo ''
                fi
                ## output all matched directories omitting the trailing newline
                for ((i=1; i<${#dir_results}; i++)); do
                    echo "${dir_results[i]//${dir_results[i]%%:$'\n'*}\//}\n"
                done
                echo "${dir_results[-1]//${dir_results[-1]%%:$'\n'*}\//}"
            fi
        else 
            ## print an error message
            if [ $correct_dir == true ]; then
                echoerr "$0: No matches found"               ## no match was found in existing directories
            else
                echoerr "$0: No such files or directories"   ## no match was found because no parameter was a file or directory
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

# list all files and directories owned by the shell user
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

# list all files and directories matching the given zsh glob qualifier
# -> glob qualifier must be the first positional argument without parentheses!!!
function lsgen() {
    _generic_ls "$@"
}


# count all non-hidden files
# TODO: vlt pro dir anzeigen lassen?
function lc() {
    ls "$@" | wc -l
}

# count all files
# TODO: vlt pro dir anzeigen lassen?
function lac() {
    ls -A "$@" | wc -l
}

# list all files without extensions in the current directory
function lne() {
    ls -AF "$@" | \egrep -v "(.+\..*|+/)" | column
}