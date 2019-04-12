# title           : ls/options.zsh
# description     : This file provides various options changing the ls command.
# date            : 2019-03-25
# dependencies    : vivid (optional)
# zsh_version     : 5.7.1
# ====================================================================================


# change ls colors (if vivid is installed use it because of much easier custimization)
local current_dir=$(cd "$(dirname "$0")" ; pwd -P)
if (( $+commands[vivid] )); then
    export LS_COLORS="$(vivid generate $current_dir/color_schemes/solarized)"
else
    eval "$(dircolors $current_dir/color_schemes/solarized.dircolors)"
fi

# zsh completion should use LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
