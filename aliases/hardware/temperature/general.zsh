# ==== General Temperature Information ====
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
    if (command_exists hddtemp) || (command_exists nvme) ; then
        echo -e "\033[1mMemory Devices Temperatures:\033[0m"
        memory-temp
    fi
}