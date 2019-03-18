# ==== Processes ====
alias jobs='jobs -l'                            # displays status of jobs in the current shell session including IDs
alias jobsr='\jobs -lr'                         # display only running jobs with IDs
alias jobss='\jobs -ls'                         # display only stopped jobbs with IDs
alias pstree='pstree -lh'                       # show current process-tree, highlighting current process
alias pss='ps -fC'                              # find processes by name
alias psa='ps -aux | less'                      # list all processes (using less)
alias psram='ps aux | sort -nr -k 4 | head -10' # get top 10 process eating memory
alias pscpu='ps aux | sort -nr -k 3 | head -10' # get top 10 process eating cpu
if command_exists htop ; then
    alias htop='htop -s PERCENT_CPU'            # be sure htop sorts all process by CPU percentage
fi
alias hs='history | \egrep -i '                 # search for specific command in history