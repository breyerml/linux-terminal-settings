### List of touched commands

#### 1. aliases.zsh

- `command_exists()`   checks if passed command exists
- `file_exists()` checks if passed filename exists
- `has_elevated_privileges` checks if it is possible for the user to gain root rights
- `grep`  command-line utility for searching plain-text data sets
- `egrep` extended grep
- `fgrep` fixed string grep
- `rgrep` recursive grep
- `gits` show git status message
- `gitd` show git difference
- `gitc` commit staged changes
- `gita` add all untracked and/or changed files
- `gitac` add all untracked and/or changed files and commit them
- `gitl` show log as graph with abbreviated commit ids
- `bc` a math library
- `wget` continue wget in case of error
- `chown` change owner
- `chmod` change mode
- `chgrp` change group
- `path` list all PATH variables
- `manpath` list all MAN_PATH variables
- `ld_library_path` list all LD_LIBRARY_PATH variables
- `pkg_config_path` list all PKG_CONFIG_PATH variables
- `diff` 
- `goodnight` shutdown the computer
- `today` display date

##### 2. directory.zsh

- `ls` list files
- `la` show all files (including hidden ons; excluding . and ..)
- `l.` only show hidden files
- `l` list all files with details
- `ll` list non-hidden files with details
- `lp` list non-hidden files with full path
- `lr` list non-hidden files recursively
- `lc` count all non-hidden files
- `lac` count all files
- `lf` find all files with the given pattern
- `lt` list all files sorted by time (newest first)
- `ltr` list all files sorted by time (oldest first)
- `lss` list all files sorted by size (biggest first)
- `lssr` list all files sorted by size (smallest first)
- `dirtree` show non-hidden directories in tree format
- `filetree` show non-hidden directories and files with their corresponding size
- `...` move two directories up
- `....` move three directories up
- `.....` move four directories up
- `......` move five directories up
- `cpwd` copy current working directory to clipboard
- `mkdir` make parent directories if needed (nothing otherwise) and print created directories
- `rmdir` delete all parent directories and print deleted directories
- `mkcd` create new directory and cd in it
- `findf` find files or directories with a given pattern in a given directory
- `findh` find files or directories in the current directory with a given pattern
- `toucht` touch with template support
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

##### 3. hardware.zsh

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


for further informations see:
- [directory README](directory/README.md)
- [hardware README](hardware/README.md)
