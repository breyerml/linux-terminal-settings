# title           : ccd/options.zsh
# description     : This file changes to ccd commands autocomplete appereance
# date            : 2019-04-12
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# display group descriptions only for ccd command
zstyle ':completion:*:*:ccd:*:descriptions' format "%B- %d -%b"

# use tag names for displaying
zstyle ':completion:*:*:ccd:*:*' group-name ''
