# CPU

## Description

The plugin provides aliases related to CPU information.

## Aliases

The following aliases are defined:

| Alias      | Implementation             | Description            |
| ---------- | -------------------------- | ---------------------- |
| `cpu`      | `lscpu`                    | list cpu infos (short) |
| `cpu-info` | `cat /proc/cpuinfo | less` | list cpu infos (long)  |
