# ==== Memory ====
if (command_exists hddtemp) || (command_exists nvme) ; then
    function memory-temp() {                   # display memeory temperatures
        if has_elevated_privileges ; then
            if command_exists hddtemp ; then
                local count=$(find /dev -name "sd?" | wc -l)
                if [[ $count != 0 ]]; then
                    sudo hddtemp /dev/sd?                   ## hdd temperatures
                    echo
                fi
                
            fi
            if command_exists nvme ; then
                local nvmes=$(find /dev -name "nvme?")      ## nvme temperatures
                while read -r nvmes; do
                    local res=$(sudo nvme smart-log /dev/nvme?)
                    echo $res | \grep "Smart Log"
                    echo $res | \grep "temperature"
                done <<< "$nvmes"
            fi
        else
            echo "Error: elevated privileges needed!"
        fi
    }
fi