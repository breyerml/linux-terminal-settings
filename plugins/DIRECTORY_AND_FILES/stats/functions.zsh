# title           : stats/functions.zsh
# description     : This file provides functions to display file and directory statistics.
# date            : 2019-04-29
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# ==== show statistic for one file ====
function pstat() {
  for file in "$@"; do
    ## name - type - owner - size - permissions - access - modify - change
    local -a values=( ${(f)"$(stat --printf "%N\n%F\n%U\n%s\n%A\n%X\n%Y\n%Z" $file)"} )

    ## check if stat command succeded
    if [[ -n $values ]]; then
      ## name: remove trailing and leading '
      echo "Name:\t\t${values[1]:1:-1}"
      ## type
      echo "Type:\t\t${values[2]}"
      ## owner
      echo "Owner:\t\t${values[3]}"
      ## size human readable
      local num_size=$(numfmt --to=iec-i --suffix='B' ${values[4]})
      echo "Size:\t\t$num_size"
      ## permissions
      echo "Permissions:\t${values[5]}"
      ## last access date
      local access_date=$(date -d @${values[6]} +"%Y-%m-%d %H:%M:%S")
      echo "Access:\t\t$access_date"
      ## last modification date
      local modifiy_date=$(date -d @${values[7]} +"%Y-%m-%d %H:%M:%S")
      echo "Modify:\t\t$modifiy_date"
      ## last change date
      local change_date=$(date -d @${values[8]} +"%Y-%m-%d %H:%M:%S")
      echo "Change:\t\t$change_date"

      ## separate file statistics if not the last file
      if [[ $file != ${@[-1]} ]]; then
        echo
      fi
    fi
  done
}


# show statistics for directories
if ! (( $+commands[ncdu] )); then
  ## list all directory sizes human-readable in descending order
  function dud() {
    for dir in "$@"; do
      command du -hc "$dir" | sort -hr

      ## separate direcory statistics if not the last directory
      if [[ $dir != ${@[-1]} ]]; then
        echo
      fi
    done
  }

  ## list all file sizes human-readable in descending order
  function duf() {
    for dir in "$@"; do
      command du -ahc "$dir" | sort -hr

      ## separate direcory statistics if not the last directory
      if [[ $dir != ${@[-1]} ]]; then
        echo
      fi
    done
  }
fi
