# ls (list)

## Description

This plugin defines useful aliases and functions to display the contents of a directory with coloring.

## Options

If [vivid](https://github.com/sharkdp/vivid) is installed, it is used to change the `LS_COLORS` environmental variable based on the [solarized color scheme](https://en.wikipedia.org/wiki/Solarized_(color_scheme)) (also influencing the zsh completion system).

If vivid isn't installed, uses the `dircolor` file ([see](https://github.com/trapd00r/LS_COLORS)) in the current directory to specify the `LS_COLORS` environmental variable.

## Aliases

The following aliases are defined:

| Alias  | Implementation     | Description                                    |
| ------ | ------------------ | ---------------------------------------------- |
| `la`   | `ls -A`            | list all files                                 |
| `l.`   | `ls -Ad .?*`       | list hidden files only                         |
| `l`    | `ls -lhA`          | list all files with details                    |
| `ll`   | `ls -lh`           | list non-hidden files with details             |
| `lp`   | `ls -d "$(pwd)"/*` | list non-hidden files with full path           |
| `lr`   | `ls -lRh`          | list non-hidden files recursively              |
| `lt`   | `ls -Alht`         | list all files sorted by time (newest first)   |
| `ltr`  | `ls -Alhtr`        | list all files sorted by time (oldest first)   |
| `lss`  | `ls -AlhS`         | list all files sorted by size (biggest first)  |
| `lssr` | `ls -AlhSr`        | list all files sorted by size (smallest first) |

## Functions

The following functions are defined:

| Function  | Description                                                                                                                                                    |
| --------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `lc`      | `ls | wc -l`                                                                                                                                                   | count all non-hidden files        |
| `lca`     | `ls -A | wc -l`                                                                                                                                                | count all files                   |
| `lne`     | `ls -d ^?*.*(D.)`                                                                                                                                              | list all files without extensions |
| `lsexec`  | list all executable files                                                                                                                                      |
| `lsempty` | list all empty files and directories                                                                                                                           |
| `lsmy`    | list all files owned by the shell user                                                                                                                         |
| `lstoday` | list all files modified today (since midnight)                                                                                                                 |
| `lsgen`   | list all files and directories matching the given zsh glob qualifier <br /> **→ the glob qualifier must be the first positional argument without parentheses** |