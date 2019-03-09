#### DIRECTORY AND FILE RELATED ALIASES AND FUNCTIONS

# ==== list (ls) ====
alias ls='ls --color=auto --time-style=+"%Y-%m-%d %H:%M:%S"'  # color output if possible and change time stamp to (e.g.): 2019-03-05 18:48:51
alias la='ls -A'                            # show all files (including hidden ons; excluding . and ..)
alias l.='ls -Ad .?*'                       # only show hidden files
alias l='ls -lhA'                           # list all files with details
alias ll='ls -lh'                           # list non-hidden files with details
alias lp='ls -d "$(pwd)"/*'                 # list non-hidden files with full path
alias lr='ls -lRh'                          # list non-hidden files recursively
alias lc='ls | wc -l'                       # count all non-hidden files
alias lac='ls -A | wc -l'                   # count all files
alias lf='ls -hAF | grep -E'                # find all files with the given pattern
alias lt='ls -Alht'                         # list all files sorted by time (newest first)
alias ltr='ls -Alhtr'                       # list all files sorted by time (oldest first)
alias lss='ls -AlhS'                        # list all files sorted by size (biggest first)
alias lssr='ls -AlhSr'                       # list all files sorted by size (smallest first)

# ==== tree ====
if command_exists tree ; then
    alias dirtree='tree -d '                # show non-hidden directories in tree format
    alias filetree='tree --du -sh '         # show non-hidden directories and files with their corresponding size
else 
    function dirtree() {                    # show non-hidden directories in tree format (fallback if "tree" isn't installed)
        for dir in "$@"; do
            if [[ -d $dir ]]; then          ## output error if passed parameter isn't a valid directory
                ls -R $dir | grep --color=never ':$' | sed -e 's/:$//' -e 's/[^\/]*\//|  /g' -e 's/|  \([^|]\)/|–– \1/g'
                echo 
            else 
                echo "Not a directory!: $dir"
            fi 
        done
    }
fi

# ==== change directory (cd) ====
if [ -n "$ZSH_VERSION" ]; then              ## global aliases only defined in ZSH
    alias -g ...='../..'                    # move two directories up
    alias -g ....='../../..'                # move three directories up
    alias -g .....='../../../..'            # move four directories up
    alias -g ......='../../../../..'        # move five directories up
fi
function cd() {                             # cd with the option to jump back to a given directory in the current working directory
    local next_dir=$1
    builtin cd $next_dir >/dev/null 2>&1        ## try to cd
    if [[ $? != 0 ]]; then                      ## try to jump back if cd failed
        if [[ ${next_dir: -1} == '/' ]]; then   ## delete trailing "/" if present
            next_dir=${next_dir: : -1}
        fi
        if [[ $PWD == *$next_dir* ]]; then      ## check if you can jump to the specific directory
            local new_dir=$(pwd | nawk -F "/$next_dir/" '{print $1}')
            builtin cd $new_dir'/'$next_dir
        else                                    ## illegal cd
            echo "cd: no such file or directory: $next_dir"
        fi
    fi
}

# ==== other ====
alias cpwd='pwd | tr -d "\n" | clipcopy'    # copy current working directory to clipboard TODO: clipcopy selber
alias mkdir='mkdir -pv '                    # make parent directories if needed (nothing otherwise) and print created directories
alias rmdir='rmdir -pv '                    # delete all parent directories and print deleted directories
function mkcd() { mkdir $1; cd $1 }         # create new directory and cd in it
function findf() { find $1 -iname $2 }      # find files or directories with a given pattern in a given directory
function findh() { find . -iname $1 }       # find files or directories in the current directory with a given pattern
function toucht() {                         # touch with template support
    for file in "$@"; do                              ## support multiple files at once
        ## search for all templates in ~/Tempplates matching the specific filename extension
        local templates=$(find ~/Templates -type f -iname "*.${file##*.}")

        ## fill array with possible matching templates found in ~/Templates
        declare -a array
        while read -r templates; do
            array+=($templates)
        done <<< "$templates"

        if [[ ${#array[@]} == 0 ]]; then              ## no template provided -> use default touch
            touch $file
        elif [[ ${#array[@]} == 1 ]]; then            ## use the provided template
            \cp ${array[1]} $file
        else                                          ## select one of the provided templates
            ## print the selection dialog containing all matched templates and wait for the user input
            echo "Please select one of the following templates (${#array[@]}):\n"
            for (( i=0; i<${#array[@]}; i++ )); do
                echo "  [$i] $(basename ${array[$i+1]})"
            done
            echo "\nYour choice: \c"
            read choice
            ## check if the user input is a correct choice 
            ## i.e. it is a valid number less then the number of possible templates
            if [[ $choice =~ ^[0-9]+$ && $choice -lt ${#array[@]} ]]; then
                \cp ${array[$choice+1]} $file
            else 
                echo "Illegal choice!"
                return 1
            fi
        fi
    done
}
function pstat() {                          # show statistic for one file
    ## Name - Type - Owner - Size - Permissions - Access - Modify - Change
    local values=$(stat --printf "%N\n%F\n%U\n%s\n%A\n%X\n%Y\n%Z" $1)
    if [[ -n $values ]]; then               ## check if stat command succeded
        declare -a name_array=("Name:\t\t" "Type:\t\t" "Owner:\t\t" "Size:\t\t" "Permissions:\t" "Access:\t\t" "Modify:\t\t" "Change:\t\t")
        declare -a value_array
        while read -r values; do
            value_array+=($values)
        done <<< "$values"

        ## pretty format size and time values
        value_array[4]=$(numfmt --to=iec --suffix='B' ${value_array[4]})
        for (( i=6; i<9; i++ )); do
            value_array[$i]=$(date -d @${value_array[$i]} +"%Y-%m-%d %H:%M:%S")
        done

        ## output everything
        for (( i=1; i<9; i++ )); do
            echo ${name_array[$i]}${value_array[$i]}
        done
    fi
}
if command_exists ncdu ; then
    alias duc='ncdu '                            # use "ncdu"hardware.zsh as "du" alternativ
else 
    function duc() { \du -hc $1 | sort -hr }     # list all non-hidden file sizes human-readable in descending order
    function dua() { \du -ahc $1 | sort -hr }    # list all file sizes human-readable in descending order
fi


# ==== stay save ====
alias rm='rm -iv --preserve-root '          # always ask before removing, preserve root directory and show deleted files/directories
alias mv='mv -iv '                          # always ask before moving and show moved files/directories
alias cp='cp -iv '                          # always ask before copying and show copied files/directories
alias ln='ln -iv '                          # always ask before linking and show linked files/directories

# ==== spell checking ====
alias cd..='cd ..'
alias cd-='cd -'
alias cd~='cd ~'
alias dc..='dc ..'
alias dc-='dc -'
alias dc~='dc ~'
