#### HARDWARE AND PROCESS RELATED ALIASES AND FUNCTIONS

if command_exists htop ; then
    alias htop='htop -s PERCENT_CPU'            # be sure htop sorts all process by CPU percentage
fi

if command_exists nvidia-smi ; then             # use nvidia-smi to display gpu info if possible else use fallback
    alias gpu='nvidia-smi'
else
    alias gpu='lspci -vnn | \grep VGA -A 12'
fi

alias ram='free -h'                             # list current RAM usaged
function ram-info() {                           # list RAM info: usage + more infos
    free -h
    if has_elevated_privileges ; then
        echo 
        sudo lshw -short -C memory
    fi
}

if command_exists pydf ; then                   # use pydf to print current memory usage if possible else use fallback df
    alias memory='pydf -h'
else
    alias memory='df -h'
fi

alias cpu='lscpu'                               # list cpu infos (short)
alias cpu-info='cat /proc/cpuinfo | less'       # list cpu infos (longer)

#if has_elevated_privileges ; then
    alias ports='netstat -taupen'          # list all open ports 
#fi

if command_exists sensors ; then
    

    alias temperature='sensors'                 # show PCI device temperatures
fi

function temp() {
    if command_exists sensors ; then
        echo -e "\033[1mCPU Temperatures:\033[0m"
        sensors
    fi
    if command_exists nvidia-smi ; then
        echo -e "\033[1mGPU Temperatures:\033[0m"
        local gpus="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)"
        local count=1
        while read -r gpus; do
            echo "GPU $count: $gpus°C"
            counter=$((counter + 1))
        done <<< "$gpus"
        echo 
    fi
    if (command_exists hddtemp) && (has_elevated_privileges) ; then
        echo -e "\033[1mMemory Device Temperatures:\033[0m"
        local devices=$(ls /dev | \grep "sd.")
        while read -r devices; do
            if ! [[ $devices =~ [^A-Za-z]+ ]]; then
                sudo hddtemp "/dev/$devices"
            fi
        done <<< "$devices"
    fi 
}