# ccd (wrapper to integrate warp functionality into cd)

## Description

This plugin provides integration of the warp functionality into the cd command.

## Aliases

An alias `alias cd=ccd` is used to propagate the custom function to the normal cd command.

## Functions

One function is provided: `ccd`

Tries to normally `cd` to the given directory. If that isn't possible, the input is treated as a warp point and it will be tried to `cd` to its directory.
If that also doesn't succeed, an error is thrown.

## Options

Changed zsh's zstyle to integrate warp points in a more satisfying way.
s
## Completion

The new `ccd` command can complete directories and warp points.
