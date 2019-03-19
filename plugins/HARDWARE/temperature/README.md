# Hardware temperature

## Description

The plugin provides aliases and functions to retrieve the temperature of various System components.

## Aliases

The following aliases are defined:

| Alias      | Implementation | Description              |
| ---------- | -------------- | ------------------------ |
| `cpu-temp` | `sensors`      | display CPU temperatures |


## Aliases

The following functions are defined:

| Alias         | Description                                                                                                           |
| ------------- | --------------------------------------------------------------------------------------------------------------------- |
| `gpu-temp`    | display GPU temperatures <br />(**up to now just for NVIDIA GPUs using `nvidia-smi`**)                                |
| `memory-temp` | display memory temperatures (HDD and NVME) <br />(**only avaible if `hddtemp` or `nvme` are installed respectively**) |
| `temp-info`   | display temperatures <br />(**only avaible if the corresponding commands are installed**)                             |

