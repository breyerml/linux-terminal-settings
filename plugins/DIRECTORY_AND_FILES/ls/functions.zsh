# title           : ls/functions.zsh
# description     : This file provides various functions to the ls command.
# date            : 2019-03-22
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# list all executable files
function lsexec() {
    setopt local_options no_null_glob
    if [[ $# == 0 ]]; then
        ls -l *(*)
    else
        ls -l ${^@}/*(*)
    fi
}

# list all empty files and directories
function lsempty() {
    setopt local_options no_null_glob
    if [[ $# == 0 ]]; then
        ls -ld --group-directories-first *(L0,/^F)
    else
        ls -ld --group-directories-first ${^@}/*(L0,/^F)
    fi
}

# list all files owned by the shell user
function lsmy() {
    setopt local_options no_null_glob
    if [[ $# == 0 ]]; then
        ls -ld *(U)
    else
        ls -ld ${^@}/*(U)
    fi
}

# list all files modified today (since midnight)
function lstoday() {
    setopt local_options no_null_glob
    integer sec_passed=$(date -d "1970-01-01 UTC $(date +%T)" +%s)
    if [[ $# == 0 ]]; then
        ls -ld *(ms-$sec_passed)
    else
        ls -ld ${^@}/*(ms-$sec_passed)
    fi
}