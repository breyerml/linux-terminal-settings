#### HARDWARE AND PROCESS RELATED ALIASES AND FUNCTIONS

if command_exists htop ; then
    alias htop='htop -s PERCENT_CPU'            # be sure htop sorts all process by CPU percentage
fi

if command_exists nvidia-smi ; then             # use nvidia-smi to display gpu info if possible else use fallback
    alias gpu='nvidia-smi'
else
    alias gpu='lspci -vnn | grep VGA -A 12'
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
        echo "Mainboard Device Temperatures:"
        sensors
    fi
    if (command_exists hddtemp) && (has_elevated_privileges) ; then
        echo "Memory Device Temperatures:"
        local devices=$(ls /dev | \grep "sd.")
        while read -r devices; do
            if ! [[ $devices =~ [^A-Za-z]+ ]]; then
                sudo hddtemp "/dev/$devices"
            fi
        done <<< "$devices"
    fi 
}