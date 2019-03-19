# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="git-status"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
colorize
catimg
copybuffer
dircycle
extract_unalias
web-search
alias-tips
oh-my-matrix
terminal-workload-report
zsh-vim-plugin
command-time
)

source $ZSH/oh-my-zsh.sh

# Jump back to given directory
source $ZSH/custom/plugins/zsh-bd/bd.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='xed' # TODO: change
  export VISUAL='xed' # TODO: change
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

if [[ -z $CUSTOM_ZSH_ROOT ]]; then
        export CUSTOM_ZSH_ROOT="$( cd "$(dirname "$0")" ; pwd -P )"
	[ -r $CUSTOM_ZSH_ROOT/aliases.zsh ] && .  $CUSTOM_ZSH_ROOT/aliases.zsh
	[ -r $CUSTOM_ZSH_ROOT/aliases/directory.zsh ] && source $CUSTOM_ZSH_ROOT/aliases/directory.zsh	
	[ -r $CUSTOM_ZSH_ROOT/aliases/hardware.zsh ] && source $CUSTOM_ZSH_ROOT/aliases/hardware.zsh
fi


# extract compressed files
extract() {
  if [[ -f $1 ]]
  then
    case "$1" in
      *.tar.bz2)  tar -xvjf "$1"    ;;
      *.tar.gz)   tar -xvzf "$1"    ;;
      *.bz2)      bunzip2 "$1"      ;;
      *.rar)      unrar -x "$1"     ;;
      *.gz)       gunzip "$1"       ;;
      *.tar)      tar -xvf "$1"     ;;
      *.tbz2)     tar -xvjf "$1"    ;;
      *.tgz)      tar -xvzf "$1"    ;;
      *.zip)      unzip "$1"        ;;
      *.Z)        uncompress "$1"   ;;
      *.7z)       7z x "$1"        ;;
      *)          echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# archive files with a given compression
archive() {
  if [ "$#" -lt 2 ]
  then
    echo "not enough parameters"
    return 1
  fi

  for X in "${@:2}"
  do
    if ! [[ -f $X || -d $X ]]
    then
      echo "'$X' is not a file or directory"
      return 1
    fi
  done

  case "$1" in
    "tar.bz2")    tar -cvjSf archive.tar.bz2 "${@:2}" ;;
    "tar.gz")     tar -czf archive.tar.gz "${@:2}"    ;;
    "rar")        rar a -m5 archive.rar "${@:2}"      ;;
    "tar")        tar -cf archive.tar "${@:2}"        ;;
    "tbz2")       tar -jcvf archive.tbz2 "${@:2}"     ;;
    "tgz")        tar -zcvf archive.tgz "${@:2}"      ;;
    "zip")        zip archive.zip "${@:2}"            ;;
    "7z")         7z a -t7z -m0=LZMA -mmt=on -mx=9 -md=96m -mfb=256 archive.7z "${@:2}"    ;;
    *)            echo "'$1' is no valid archive type"
  esac
}


# terminal calculator
alias calculator='gcalccmd'