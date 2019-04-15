# title           : dot_cd/options.zsh
# description     : This file provides options for the custom dot-expand widget
# date            : 2019-04-14
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# complete .. as special dir (adds a / at the end if legal)
zstyle ':completion:*' special-dirs ..

# directory and executable files completion on empty command line
zstyle ':completion::*' insert-tab 'pending=1'
zstyle ':completion::*:-command-::' file-patterns '*(#q-*):executables:Executables *(-/):directories:Directories'
zstyle ':completion::*:-command-::(commands|builtins|functions|aliases|suffix-aliases|reserved-words|jobs|parameters)' ignored-patterns '*'

# always group results and list directories first
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
