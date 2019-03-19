# ls (list)

## Description

This plugin defines useful aliases to display the contents of a directory.

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
| `lc`   | `ls | wc -l`       | count all non-hidden files                     |
| `lca`  | `ls -A | wc -l`    | count all files                                |
| `lf`   | `ls -hAF | egrep`  | find all files with the given pattern          |
| `lt`   | `ls -Alht`         | list all files sorted by time (newest first)   |
| `ltr`  | `ls -Alhtr`        | list all files sorted by time (oldest first)   |
| `lss`  | `ls -AlhS`         | list all files sorted by size (biggest first)  |
| `lssr` | `ls -AlhSr`        | list all files sorted by size (smallest first) |
