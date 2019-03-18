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