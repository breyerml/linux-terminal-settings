# Safety

## Description

The plugin provides simple safety nets.

## Aliases

The following safety nets are defined:

| Alias   | Safety net               | Description                                                                            |
| ------- | ------------------------ | -------------------------------------------------------------------------------------- |
| `rm`    | `rm -iv --preserve-root` | always ask before removing, preserve root directory and show deleted files/directories |
| `mv`    | `mv -iv`                 | always ask before moving and show moved files/directories                              |
| `cp`    | `cp -iv`                 | always ask before copying and show copied files/directories                            |
| `ln`    | `ln -iv`                 | always ask before linking and show linked files/directories                            |
| `chown` | `chown --preserve-root`  | always preserve root directory                                                         |
| `chmod` | `chmod --preserve-root`  | always preserve root directory                                                         |
| `chgrp` | `chgrp --preserve-root`  | always preserve root directory                                                         |

