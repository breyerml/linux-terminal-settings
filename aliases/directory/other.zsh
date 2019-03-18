#TODO sauber aufteilen

# ==== other ====
alias cpwd='pwd | tr -d "\n" | clipcopy'    # copy current working directory to clipboard TODO: clipcopy selber
alias mkdir='mkdir -pv '                    # make parent directories if needed (nothing otherwise) and print created directories
alias rmdir='rmdir -pv '                    # delete all parent directories and print deleted directories
function mkcd() { mkdir $1; cd $1 }         # create new directory and cd in it
function findf() { find $1 -iname $2 }      # find files or directories with a given pattern in a given directory
function findh() { find . -iname $1 }       # find files or directories in the current directory with a given pattern