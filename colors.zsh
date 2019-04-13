# title           : colors.zsh
# description     : Defines the used color scheme
# date            : 2019-04-13
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# solarized color scheme
typeset -A SOLARIZED_COLORS                          #   hex           rgb        xterm
SOLARIZED_COLORS[base03]=$'\e[38;2;0;43;54m'         # #002b36      (0,43,54)      234
SOLARIZED_COLORS[base03]=$'\e[38;2;7;54;66m'         # #073642      (7,54,66)      235
SOLARIZED_COLORS[base01]=$'\e[38;2;88;110;117m'      # #586e75     (88;110;117)    240
SOLARIZED_COLORS[base00]=$'\e[38;2;101;123;131m'     # #657b83    (101,123,131)    241
SOLARIZED_COLORS[base0]=$'\e[38;2;131;148;150m'      # #839496    (131,148,150)    244
SOLARIZED_COLORS[base1]=$'\e[38;2;147;161;161m'      # #93a1a1    (147,161,161)    245
SOLARIZED_COLORS[base2]=$'\e[38;2;238;232;213m'      # #eee8d5    (238,232,213)    254
SOLARIZED_COLORS[base3]=$'\e[38;2;253;246;227m'      # #fdf6e3    (253,246,227)    230
SOLARIZED_COLORS[yellow]=$'\e[38;2;181;137;0m'       # #b58900     (181,137,0)     136
SOLARIZED_COLORS[orange]=$'\e[38;2;203;75;22m'       # #cb4b16     (203,75,22)     166
SOLARIZED_COLORS[red]=$'\e[38;2;220;50;47m'          # #dc322f     (220;50;47)     160
SOLARIZED_COLORS[magenta]=$'\e[38;2;211;54;130m'     # #d33682     (211,54,130)    125
SOLARIZED_COLORS[violet]=$'\e[38;2;108;113;196m'     # #6c71c4    (108,113,196)     61
SOLARIZED_COLORS[blue]=$'\e[38;2;38;139;210m'        # #268bd2     (38,139,210)     33
SOLARIZED_COLORS[cyan]=$'\e[38;2;42;161;152m'        # #2aa198     (42,161,152)     37
SOLARIZED_COLORS[green]=$'\e[38;2;133;153;0m'        # #859900     (133,153,0)      64


# font properties
typeset -A FONT
FONT[bold]=$'\e[1m'         # bold font (increased intensity)
FONT[faint]=$'\e[2m'        # faint font (decreased intensity)
FONT[italic]=$'\e[3m'       # italic font
FONT[underline]=$'\e[4m'    # underline text
FONT[reverse]=$'\e[7m'      # swap foreground and background
FONT[conceal]=$'\e[8m'      # hide text
FONT[crossout]=$'\e[9m'     # crossed out text
FONT[normal]=$'\e[10m'      # normal font without other properties


# reset font properties and colors
RESET=$'\e[0m'
