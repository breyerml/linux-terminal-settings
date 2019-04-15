# Expansion of multiple dots

## Description

This plugin provides a more convenient way to `cd` up multiple directories using dots.

## Widgets

A zle widget to move several directories upwards:

`cd ...<TAB>` → `cd ../../` <br />
`cd ....<TAB>` → `cd ../../../` <br />
etc.

It also works in the middle of a path (although writing such paths is useless):

`cd foo/.../bar<TAB>` → `cd foo/../../bar/`

## Options

Enables `..` as special directory so that `cd ...<TAB>` automatically inserts a slash / at the end producing `cd ../../`.
