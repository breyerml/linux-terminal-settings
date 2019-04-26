# title           : touch/functions.zsh
# description     : This file provides a function to create new files based on the templates in ~/Templates/.
# date            : 2019-04-26
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# touch with template support
function toucht() {
  ## support multiple files at once
  for file in "$@"; do
    ## search for all templates in ~/Tempplates matching the specific filename extension
    local -a templates=( $(find ~/Templates -type f -iname "*.${file##*.}") )

    ## check how many matching templates were found
    if [[ ${#templates[@]} == 0 ]]; then
      ## no matching template found -> use default touch
      touch $file
    elif [[ ${#templates[@]} == 1 ]]; then
      ## exactly one matching template found -> use the provided template
      command cp "${templates[1]}" "$file"
    else
      ## select one of the provided templates
      ## -> print the selection dialog containing all matched templates and wait for the user input
      echo "Please select one of the following ${#templates[@]} templates:\n"
      for (( i=0; i<${#templates[@]}; i++ )); do
        echo "  [$i] $(basename ${templates[i+1]})"
      done
      vared -p $'\nYour choice: ' -c choice
      ## check if the user input is a correct choice
      ## i.e. it is a valid number less than the number of matched templates
      if [[ $choice =~ ^[0-9]+$ && $choice -lt ${#templates[@]} ]]; then
        command cp "${templates[$choice+1]}" "$file"
      else
        ## ilegal user input -> don't create anything
        echoerr "$0: Illegal choice!"
        return 22
      fi
    fi
  done
}
