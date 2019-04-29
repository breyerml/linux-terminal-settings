# title           : dir_tree/aliases.zsh
# description     : This file provides aliases to display dir and file struture in a tree structure.
# date            : 2019-04-29
# dependencies    : tree
# zsh_version     : 5.7.1
# ====================================================================================


# if the tree command is installed, use that to display directories and files as a tree structure
if (( $+commands[tree] )) ; then
  alias tree='tree -C'                  ## color output
  alias dirtree='tree -d'               ## show non-hidden directories in tree format
  alias filetree='tree --du -sh'        ## show non-hidden directories and files with their corresponding size
fi
