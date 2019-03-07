#### HARDWARE AND PROCESS RELATED ALIASES AND FUNCTIONS

alias htop='htop -s PERCENT_CPU'                # be sure htop sorts all process by CPU percentage

if command -v nvidia-smi &>/dev/null ; then     # use nvidia-smi to display gpu info if possible else use fallback
    alias gpu='nvidia-smi'
else
    alias gpu='lspci -vnn | grep VGA -A 12'
fi

alias ram='free -h'                             # list current RAM usaged
function ram-info() {                           # list RAM info: usage + more infos
    free -h
    if sudo -v &>/dev/null ; then
        echo 
        sudo lshw -short -C memory
    fi
}

alias memory='df -h'                            # list current Memory usaged