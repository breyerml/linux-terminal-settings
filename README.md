# List of plugins

### autocd ([README](plugins/DIRECTORY_AND_FILES/autocd/README.md))
On an empty command line if `<TAB>` is pressed, all directories will be suggested (for better zsh autocd).

In addition pressing `<TAB>` on a command line only containing `./` will suggest only files marked with the executable flag.

ATTENTION: this is per default enabled if the `warp` plugin is loaded. In this case, the `autocd` plugin shall not be loaded in addition.

### dot_expand ([README](plugins/DIRECTORY_AND_FILES/dot_expand/README.md))
`cd` up in the directory stack using multiple dots (multiple dots will get expanded if not enclosed in quotes).

### ls ([README](plugins/DIRECTORY_AND_FILES/ls/README.md))
Various aliases and functions are provided for the `ls` command.

It uses dircolors to change the `LS_COLORS` variable. If [vivid](https://github.com/sharkdp/vivid) is installed it uses this instead. The default color scheme is based on the [solarized color scheme](https://en.wikipedia.org/wiki/Solarized_(color_scheme)).

### touch ([README](plugins/DIRECTORY_AND_FILES/touch/README.md))
The command `toucht` is provided that uses templates provided in `~/Templates` on creation of a new file (if possible).

### warp ([README](plugins/DIRECTORY_AND_FILES/warp/README.md))
Command to manage so called 'warp points' (i.e. shortcuts) to a specific directory.

Warp points can be created, overwritten, removed, listed and cleaned. If the new `warp` command gets a single correct warp point as argument, `cd` is invoked with the corresponding directory path.

Additionally the completion system is tweaked: on every completion of a directory all warp points are suggested too. On pressing `<TAB>` or `<RETURN>` all warp points will get expanded to their corresponding directory path.

This plugins also automatically enables everything related to the `autocd` plugin.


## Experimental

- `dirtree` show non-hidden directories in tree format
- `filetree` show non-hidden directories and files with their corresponding size
- `cpwd` copy current working directory to clipboard
- `mkdir` make parent directories if needed (nothing otherwise) and print created directories
- `rmdir` delete all parent directories and print deleted directories
- `mkcd` create new directory and cd in it
- `findf` find files or directories with a given pattern in a given directory
- `findh` find files or directories in the current directory with a given pattern
- `pstat` show statistics for a file
- `duc` list all non-hidden file sizes human-readable in descending order
- `dua` list all file sizes human-readable in descending order
- `rm` always ask before removing, preserve root directory and show deleted files/directories
- `mv` always ask before moving and show moved files/directories
- `cp` always ask before copying and show copied files/directories
- `ln` always ask before linking and show linked files/directories
- `cd..` `cd ..`
- `cd-` `cd -`
- `cd~` `cd ~`

- `cpu` list cpu infos (short)
- `cpu-info` list cpu infos (longer)
- `cpu-temp` display cpu temperatures
- `gpu` display full GPU info
- `gpu-temp` display temeprature only
- `ram` list current RAM usaged
- `ram-info` list RAM info: usage + more infos
- `memory` memory usage
- `memory-temp` display memeory temperatures
- `temp-info` diplays multiple temperature infos
- `ports` list all open ports
- `ping` default ping 5 times
- `network-adapter` list all network adapters
- `network-adapter` list all network adapters with detailed information
- `network-connected` list all devices connected to this network
- `myip` list current IPs
- `speedtest` check current internet speed
- `ifstat` display current network traffic
- `traffic-total`  display total network traffic
- `jobs` displays status of jobs in the current shell session including IDs
- `jobsr` display only running jobs with IDs
- `jobsss` display only stopped jobbs with IDs
- `pstree` show current process-tree, highlighting current process
- `pss` find processes by name
- `psa` list all processes (using less)
- `psram` get top 10 process eating memory
- `pscpu` get top 10 process eating cpu
- `htop` display hardware usage
- `hs` search for specific command in history
