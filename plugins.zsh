if [[ -z $CUSTOM_ZSH_ROOT ]]; then
        export CUSTOM_ZSH_ROOT="$( cd "$(dirname "$0")" ; pwd -P )"
fi


autoload -U parameter zleparameter


function echoerr { echo "$@" 1>&2; }


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
cpu
dir_tree
env_vars
file_and_dir_stats
git
gpu
grep
history
ls
memory
network
pager
processes
programs
ram
safety
spellchecks
temperature
time_and_date
touch
warp 
)

#setopt null_glob
#setopt extended_glob

## source all plugins
for plugin in $plugins ; do
    for file in "$CUSTOM_ZSH_ROOT"/plugins/"$plugin"/*.zsh ; do
        source "$file"
    done
done




# TODO: aufteilen!!
# ==== others ====
alias sudo='sudo '
alias bc='bc -ql'                           # don't print bc welcome and use math library
alias wget='wget -c'                        # continue wget in case of error

alias diff='colordiff'                      # always diff with colors
alias goodnight='shutdown -h now'           # shutdown computer

alias user='whoami'
alias watch='watch '

#TODO sauber aufteilen

# ==== other ====
alias cpwd='pwd | tr -d "\n" | clipcopy'    # copy current working directory to clipboard TODO: clipcopy selber
alias mkdir='mkdir -pv '                    # make parent directories if needed (nothing otherwise) and print created directories
alias rmdir='rmdir -pv '                    # delete all parent directories and print deleted directories
function mkcd() { mkdir $1; cd $1 }         # create new directory and cd in it
function findf() { find $1 -iname $2 }      # find files or directories with a given pattern in a given directory
function findh() { find . -iname $1 }       # find files or directories in the current directory with a given pattern
