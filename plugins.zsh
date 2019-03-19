if [[ -z $CUSTOM_ZSH_ROOT ]]; then
        export CUSTOM_ZSH_ROOT="$( cd "$(dirname "$0")" ; pwd -P )"
fi


autoload -U parameter zleparameter


alias sudo='sudo '
function echoerr { echo "$@" 1>&2; }

#function command_exists() {
#    if ! [ -x "$(command -v $1)" ]; then
#        return 1
#    fi
#}

function file_exists() {
    if ! [ -f $1 ]; then
        return 1
    fi
}

function has_elevated_privileges() {
    if ! sudo -v &>/dev/null ; then
        echo "NO ELEVATED PRIVILEGES"
        return 1
    fi
}

## PLUGINS

declare -a plugins=(
dir_tree 
file_and_dir_stats
ls
touch
)

## source all plugins
for plugin in $plugins ; do
    for file in plugins/$plugin/*.zsh ; do
        source "$file"
    done
done






