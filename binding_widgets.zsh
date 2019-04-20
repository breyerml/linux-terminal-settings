# title           : binding_widgets.zsh
# description     : Bind custom widgets (if loaded) to keys
# date            : 2019-04-19
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# custom <TAB> widget
function custom-expand-or-complete() {
  if [[ -n ${widgets[warp-expand]} ]]; then
    zle warp-expand
  fi
  if [[ -n ${widgets[dot-expand]} ]]; then
    zle dot-expand
  fi
  zle expand-or-complete
}

# custom <RETURN> widget
function custom-accept-line() {
  if [[ -n ${widgets[warp-expand]} ]]; then
    zle warp-expand
  fi
  if [[ -n ${widgets[dot-expand]} ]]; then
    zle dot-expand
  fi
  zle accept-line
}


# register widgets in zle
zle -N custom-expand-or-complete
zle -N custom-accept-line

# bind widgets to keys
bindkey '^I' custom-expand-or-complete
bindkey '^M' custom-accept-line
