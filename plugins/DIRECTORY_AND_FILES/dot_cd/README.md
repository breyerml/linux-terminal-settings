# Expansion of multiple dots

## Description

This plugin provides a more convenient way to `cd` up multiple directories using dots and to list directories and executable files when pressing `<TAB>` on an empty line.

## Widgets

A zle widget to move several directories upwards:

`cd ...<TAB>` → `cd ../../` <br />
`cd ....<TAB>` → `cd ../../../` <br />
etc.

It also works in the middle of a path (although writing such paths is useless):

`cd foo/.../bar<TAB>` → `cd foo/../../bar/`

It also show all directories and executables in the current directory (with a menu selection) when pressing `<TAB>` on an empty line.

## Options

Enables `..` as special directory so that `cd ...<TAB>` automatically inserts a slash / at the end producing `cd ../../`.
