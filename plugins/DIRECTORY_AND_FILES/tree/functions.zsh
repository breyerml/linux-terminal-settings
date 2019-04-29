# title           : dir_tree/functions.zsh
# description     : This file provides functions to display dir and file struture in a tree structure.
# date            : 2019-04-29
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# if the tree command is installed, use that to display directories and files as a tree structure
if ! (( $+commands[tree] )) ; then
  ## show non-hidden directories in tree format (fallback if "tree" isn't installed)
  function dirtree() {
    for dir in "$@"; do
      ## remove trailiing slash if existing
      if [[ ${dir[-1]} == '/' ]]; then
        dir="${dir:0:-1}"
      fi
      ## output error if passed parameter isn't a valid directory
      if [[ -d $dir ]]; then
        command ls -R "$dir" | grep --color=never ':$' | sed -e 's/:$//' -e 's/[^\/]*\//|  /g' -e 's/|  \([^|]\)/|–– \1/g'
        echo
      else
        echo "$0: not a directory: $dir"
      fi
    done
  }

  ## show non-hidden directories and files in tree format (fallback if "tree" isn't installed)
  function filetree() {
    for dir in "$@"; do
      ## remove trailiing slash if existing
      if [[ ${dir[-1]} == '/' ]]; then
        dir="${dir:0:-1}"
      fi
      ## output error if passed parameter isn't a valid directory
      if [[ -d $dir ]]; then
        command find "$dir" | sed -e "s/[^-][^\/]*\// |/g" -e "s/|\([^ ]\)/|––\1/"
        echo
      else
        echo "$0: not a directory: $dir"
      fi
    done
  }
fi
