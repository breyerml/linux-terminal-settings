# ==== touch with template support ====
function toucht() {
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
