# title           : ccd/options.zsh
# description     : This file changes to ccd commands autocomplete appereance
# date            : 2019-04-12
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# easily read all lines of a file into an array
zmodload zsh/mapfile

# display group descriptions only for ccd command
zstyle ':completion:*:*:ccd:*:descriptions' format "${SOLARIZED_COLORS[base2]}"$'\n'" === ${FONT[bold]}%d${FONT[normal]} ===$RESET"

# use tag names for displaying
zstyle ':completion:*:*:ccd:*:*' group-name ''


# return all warp point names concatenated as RegEx or, e.g. '(foo|bar|baz)'
function _warp_point_names() {
  local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"
  local string='('
  for line in "${(f)mapfile[$warp_file_dir]}"; do
      string+="${line%%=*}|"
  done
  echo "${string:0:-1})"
}

# color warp point names in ccd autocompletion
zstyle ':completion:*:*:ccd:*:*' list-colors "=$(_warp_point_names)=38;2;181;137;0"
