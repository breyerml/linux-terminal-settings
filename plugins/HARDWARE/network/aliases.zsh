alias ports='netstat -taupen'                   # list all open ports
alias ping='ping -c 5'                          # default ping 5 times
alias network-adapter='lspci | \egrep -i "network|ethernet"'    # list all network adapters
alias network-adapter-info='lshw -class network'                # list all network adapters with detailed information
alias traffic-total='cat /proc/net/dev'         # display total network traffic 
if (( $+commands[ifstat] )) ; then
    alias traffic='ifstat -bt'                  # display current network traffic
fi
# TODO: ifstat dependency