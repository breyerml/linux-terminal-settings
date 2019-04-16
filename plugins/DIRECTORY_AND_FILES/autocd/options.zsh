# title           : autocd/options.zsh
# description     : This file provides options for better usage of autocd on the (nearly empty) command line
# date            : 2019-04-16
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# enable cd'ing without the need to type cd
setopt autocd

# don't print a TAB when entered on an empty command line
zstyle ':completion::*' insert-tab 'pending=1'

# file pattern to only complete executable files
zstyle ':completion::*:-command-::' file-patterns \
 '*(#q-*):executables:Executables'

# when TAB entered on an empty commmand line: complete directories
# when TAB entered on an command line only containing './': complete executable files
# else: nomeal completion
zstyle -e ':completion::*:-command-::' tag-order '
    if [[ -z $PREFIX$SUFFIX ]]; then
      reply=( local-directories - )
    elif [[ $PREFIX$SUFFIX =~ ^./ ]]; then
      reply=( executables:Executables:Executables - )
    else
      reply=( )
    fi
'
