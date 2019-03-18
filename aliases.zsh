if [[ -z $CUSTOM_ZSH_ROOT ]]; then
        export CUSTOM_ZSH_ROOT="$( cd "$(dirname "$0")" ; pwd -P )"
fi


alias sudo='sudo '

function command_exists() {
    if ! [ -x "$(command -v $1)" ]; then
        return 1
    fi
}

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

function echoerr { echo "$@" 1>&2; }


if file_exists $CUSTOM_ZSH_ROOT/aliases/cd.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/cd.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/directory.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/directory.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/git.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/git.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/grep.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/grep.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/hardware.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/hardware.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/man_pages.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/man_pages.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/privileges.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/privileges.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/time.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/time.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/aliases/other.zsh ; then
    source $CUSTOM_ZSH_ROOT/aliases/other.zsh
fi

# TODO: seperate File
if file_exists $CUSTOM_ZSH_ROOT/programs/google.zsh ; then
    source $CUSTOM_ZSH_ROOT/programs/google.zsh
fi
if file_exists $CUSTOM_ZSH_ROOT/programs/paths.zsh ; then
    source $CUSTOM_ZSH_ROOT/programs/paths.zsh
fi



