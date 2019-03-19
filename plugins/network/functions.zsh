# ==== Network ====

if (( $+commands[nmap] )) ; then
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

if (( $+commands[speedtest-cli] )) ; then
    function speedtest() {                      # check current internet speed
        echo "Running speedtest..."
        result=$(speedtest-cli --simple 2>/dev/null)
        if [[ $? == 0 ]]; then                  # display download and upload speed if connected to the internet
            echo $result
        else
            echo "Error: please connect to the internet!"
        fi
    }
fi
