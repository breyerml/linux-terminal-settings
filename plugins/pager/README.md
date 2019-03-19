# Pager

## Description

The plugin sets the `PAGER` environmental variable to `less` and its options.

## Options

The following aliases are defined:

| Environmental variable | Value            | Description                                                                                            |
| ---------------------- | ---------------- | ------------------------------------------------------------------------------------------------------ |
| `LESS_TERMCAP_mb`      | `\e[1;31m`       | begin <blink>blinking</blink>                                                                          |
| `LESS_TERMCAP_md`      | `\e[1;38;5;136m` | begin <span style="color:#b58900">**bold**</span>                                                      |
| `LESS_TERMCAP_me`      | `\e[0m`          | end mode                                                                                               |
| `LESS_TERMCAP_se`      | `\e[0m`          | end standout-mode                                                                                      |
| `LESS_TERMCAP_so`      | `\e[38;5;254m`   | begin <span style="color:#eee8d5;background-color:#586e75">&nbsp;standout-mode - info box&nbsp;</span> |
| `LESS_TERMCAP_ue`      | `\e[0m`          | end underline                                                                                          |
| `LESS_TERMCAP_us`      | `\e[4;38;5;64m`  | begin <span style="color:#859900"><u>underline</u></span>                                              |
