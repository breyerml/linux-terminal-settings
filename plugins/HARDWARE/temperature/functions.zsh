# ==== GPU ====
if (( $+commands[nvidia-smi] )) ; then             # use nvidia-smi if possible
    function gpu-temp() {                       # display temeprature only
        local gpus="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)"
        local count=1
        while read -r gpus; do
            echo "GPU $count: $gpus°C"
            counter=$((counter + 1))
        done <<< "$gpus"
        echo 
    }
else
    # TODO: gpu-temp for AMD
fi


# ==== Memory ====
if (( $+commands[hddtemp] )) || (( $+commands[nvme] )) ; then # TODO: check if
    function memory-temp() {                   # display memeory temperatures
        if has_elevated_privileges ; then
            if (( $+commands[hddtemp] )) ; then
                local count=$(find /dev -name "sd?" | wc -l)
                if [[ $count != 0 ]]; then
                    sudo hddtemp /dev/sd?                   ## hdd temperatures
                    echo
                fi
                
            fi
            if (( $+commands[nvme] )) ; then
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


# ==== General Temperature Information ====
function temp-info() {                          # diplays multiple temperature infos
    ## display sensors temperatures
    if (( $+commands[sensors] )) ; then
        echo -e "\033[1mCPU Temperatures:\033[0m"
        sensors
    fi
    ## display (NVIDIA) GPU temperatures
    if (( $+commands[nvidia-smi] )) ; then
        echo -e "\033[1mGPU Temperatures:\033[0m"
        gpu-temp
    fi
    ## display memeory temperatures
    if (( $+commands[hddtemp] )) || (( $+commands[nvme] )) ; then
        echo -e "\033[1mMemory Devices Temperatures:\033[0m"
        memory-temp
    fi
}