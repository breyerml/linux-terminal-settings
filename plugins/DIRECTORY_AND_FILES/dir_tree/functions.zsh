# ==== tree ====
if (( $+commands[tree] )) ; then
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
    #TODO: filetree
fi