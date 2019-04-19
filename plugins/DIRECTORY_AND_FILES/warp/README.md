# warp (cd to marked directories)

## Description

This plugin provides a way to directly change to marked directories.

## Functions

One function is provided: `warp`

Usage:

`$ warp --add wp ~/Documents/foo/bar` <br />
→ adds a new warp point 'wp' pointing to the directory '~/Documents/foo/bar'

`$ warp --add! wp ~/Documents/foo/baz` <br />
→ overrides the already existing warp point 'wp' with '~/Documents/foo/baz'

`$ warp --remove wp` <br />
→ removes the warp point 'wp'

`$ warp --clean` <br />
→ remove all warp points targeting non existing directories

`$ warp --list` <br />
→ list all existing warp points

`$ warp --help` <br />
→ display a help message

`$ warp wp` <br />
→ directly `cd` to the directory 'wp' is pointing to

## Completion

The new `warp` command can complete all options and existing warp points.

## Widgets

A widget to expand warp point names to their directory. Default bind to `TAB` and `RETURN`.

Usage

`$ cd wp<TAB>` <br />
→ expands to `cd ~/Documents/foo/bar`

`$ echo 'Thats a wp test'<TAB>` <br />
→ won't expand since the warp point name 'wp' is quoted
