#### HARDWARE AND PROCESS RELATED ALIASES AND FUNCTIONS


# ==== CPU ====
alias cpu='lscpu'                               # list cpu infos (short)
alias cpu-info='cat /proc/cpuinfo | less'       # list cpu infos (longer)
if command_exists sensors ; then
    alias cpu-temp='sensors'                    # display cpu temperatures
fi


# ==== GPU ====
if command_exists nvidia-smi ; then             # use nvidia-smi if possible
    alias gpu='nvidia-smi'                      # display full NVIDIA GPU infos
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
    alias gpu='lspci -vnn | \grep VGA -A 12'    # display full GPU info (in case of no NVIDIA GPU is used)
fi


# ==== RAM ====
alias ram='free -h'                             # list current RAM usaged
function ram-info() {                           # list RAM info: usage + more infos
    free -h
    if has_elevated_privileges ; then
        echo 
        sudo lshw -short -C memory
    else 
        echo "Error: elevated privileges needed to display more information!"
    fi
}


# ==== Memory ====
if command_exists pydf ; then
    alias memory='pydf -h'                      # print memory usage using pydf if possible
else
    alias memory='df -h'                        # use normal df to print memory usage
fi
if command_exists hddtemp ; then
    function memory-temp() {                   # display memeory temperatures
        if has_elevated_privileges ; then
            local count=$(find /dev -name "sd?" | wc -l)
            if [[ $count != 0 ]]; then
                sudo hddtemp /dev/sd?
            fi
        else
            echo "Error: elevated privileges needed!"
        fi
    }
fi
if command_exists nvme ; then
    function nvme-temp() {
        if has_elevated_privileges ; then
            local count=$(find /dev -name "nvme?" | wc -l)
            if [[ $count != 0 ]]; then
                sudo nvme smart-log /dev/nvme?
            fi
        else 
            echo "Error: elevated privileges needed!"
        fi
    }
fi

function temp-info() {                          # diplays multiple temperature infos
    ## display sensors temperatures
    if command_exists sensors ; then
        echo -e "\033[1mCPU Temperatures:\033[0m"
        sensors
    fi
    ## display (NVIDIA) GPU temperatures
    if command_exists nvidia-smi ; then
        echo -e "\033[1mGPU Temperatures:\033[0m"
        gpu-temp
    fi
    ## display memeory temperatures
    if command_exists hddtemp ; then
        echo -e "\033[1mMemory Devices Temperatures:\033[0m"
        memory-temp
    fi
}


# ==== Network ====
alias ports='netstat -taupen'                   # list all open ports
alias ping='ping -c 5'                          # default ping 5 times
alias network-adapter='lspci | \egrep -i "network|ethernet"'    # list all network adapters
alias network-adapter-info='lshw -class network'                # list all network adapters with detailed information
if command_exists nmap ; then
    function network-connected() {
        local private_ip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | sed 's/\.[^.]*$//')
        if [[ -n $private_ip ]]; then               # list all devices connected to this network
            if has_elevated_privileges ; then
                sudo nmap "$private_ip.0/24"
            else 
                nmap "$private_ip.0/24"
            fi
        fi
    }
fi
function myip() {                               # list current IPs
    local private_ip=$(hostname -I)
    if [[ -n $private_ip ]]; then               # list private IP if reslove succedded
        echo "Private IP Address:\t\c"
        echo $private_ip
    fi
    local public_ip=$(curl -s ifconfig.me)
    if [[ -n $public_ip ]]; then                # list public IP if a internet connection exists
        echo "Public IP Address:\t\c"
        echo $public_ip
    fi
}
if command_exists speedtest-cli ; then
    function speedtest() {                      # check current internet speed
        echo "Running speedtest..."
        result=$(speedtest-cli 2>/dev/null)
        if [[ $? == 0 ]]; then                  # display download and upload speed if connected to the internet
            echo $result | \grep "Download"
            echo $result | \grep "Upload"
        else
            echo "Error: please connect to the internet!"
        fi
    }
fi
if command_exists ifstat ; then
    alias traffic='ifstat -bt'                  # display current network traffic
fi
alias traffic-total='cat /proc/net/dev'         # display total network traffic 


# ==== Processes ====
if command_exists htop ; then
    alias htop='htop -s PERCENT_CPU'            # be sure htop sorts all process by CPU percentage
fi