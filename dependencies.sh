#!/bin/bash

function command_exists() {
    if ! [ -x "$(command -v $1)" ]; then
        return 1
    fi
}
function has_elevated_privileges() {
    if ! sudo -v &>/dev/null ; then
        echo "NO ELEVATED PRIVILEGES"
        return 1
    fi
}

dependencies=(tree ncdu pydf hddtemp htop speedtest-cli ifstat nmap)

for dep in "${dependencies[@]}"; do
    if command_exists $dep ; then
        echo "$dep already installed"
    else 
        if has_elevated_privileges ; then
            echo "Installing $dep..."
            sudo apt-get install $dep           # TODO: other distros?
        fi
    fi
done

if command_exists sensors ; then
    echo "lm-sensors already installed"
else 
    if has_elevated_privileges ; then
        echo "Installing lm-sensors..."
        sudo apt-get install lm-sensors         # TODO: other distros?
    fi
fi


# tree                  show file hierarchy as tree
# ncdu                  interactive du (via ncurses)
# lm-sensors            display sensor information (temperatures)
# pydf                  prettier "df"
# hddtemp               display HDD temperatures
# htop                  better "top" alternativ
# speedtest-cli         terminal speedtest
# ifstat                display current network traffic
# nmap                  show network devices