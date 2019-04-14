# Network

## Description

The plugin provides aliases and functions related to the current network.

## Aliases

The following aliases are defined:

| Alias                  | Implementation                         | Description                                                                         |
| ---------------------- | -------------------------------------- | ----------------------------------------------------------------------------------- |
| `ports`                | `netstat -taupen`                      | list all open ports                                                                 |
| `ping`                 | `ping -c 5`                            | default ping 5 times                                                                |
| `network-adapter`      | `lspci | \egrep -i "network|ethernet"` | list all network adapters                                                           |
| `network-adapter-info` | `lshw -class network`                  | list all network adapters with detailed information                                 |
| `traffic-total`        | `cat /proc/net/dev`                    | display total network traffic                                                       |
| `traffic`              | `ifstat -bt`                           | display current network traffic <br />(**only available if `ifstat` is installed**) |


## Functions

The following functions are defined:

| Function            | Description                                                                                         |
| ------------------- | --------------------------------------------------------------------------------------------------- |
| `myip`              | list current IP addresses                                                                           |
| `network-connected` | list all devices connected to the current network <br />(**only available if `nmap` is installed**) |
| `speedtest`         | check current internet speed <br />(**only available if `speedtest-cli` is installed**)             |