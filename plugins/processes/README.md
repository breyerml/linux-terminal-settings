# Processes

## Description

The plugin provides aliases related to processes and jobs.

## Aliases

The following aliases are defined:

| Alias    | Implementation                      | Description                                                        |
| -------- | ----------------------------------- | ------------------------------------------------------------------ |
| `jobs`   | `jobs -l`                           | displays status of jobs in the current shell session including IDs |
| `jobsr`  | `jobs -lr`                          | isplay only running jobs with IDs                                  |
| `jobss`  | `jobs -ls`                          | display only stopped jobbs with IDs                                |
| `pstree` | `pstree -lh`                        | show current process-tree, highlighting current process            |
| `pss`    | `ps -fC`                            | find processes by name                                             |
| `psa`    | `ps -aux | less`                    | list all processes                                                 |
| `psram`  | `ps aux | sort -nr -k 4 | head -10` | get top 10 process eating memory                                   |
| `pscpu`  | `ps aux | sort -nr -k 3 | head -10` | get top 10 process eating cpu                                      |
| `htop`   | `htop -s PERCENT_CPU`               | be sure htop sorts all process by CPU percentage                   |
