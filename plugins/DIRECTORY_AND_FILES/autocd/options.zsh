# title           : autocd/options.zsh
# description     : This file provides options for better usage of autocd on the (nearly empty) command line
# date            : 2019-04-16
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================

# easily read all lines of a file into an array
zmodload zsh/mapfile

# enable cd'ing without the need to type cd
setopt autocd

# don't print a TAB when entered on an empty command line
zstyle ':completion::*' insert-tab 'pending=1'

# file pattern to only complete executable files and directories
zstyle ':completion::*:-command-::' file-patterns \
 '*(#q-*):executables:Executables *(-/):directories:Directories'


 # return all warp point names concatenated as RegEx or, e.g. '(foo|bar|baz)'
 function _warp_point_names_space_separated() {
   local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"
   local string=' '
   for line in "${(f)mapfile[$warp_file_dir]}"; do
       string+="${line%%=*} "
   done
   echo "$string"
 }

 function _warp_point_names_pipe_separated() {
   local warp_file_dir="$ZSH_CUSTOM_ROOT/plugins/DIRECTORY_AND_FILES/warp/.warp_points"
   local string='('
   for line in "${(f)mapfile[$warp_file_dir]}"; do
       string+="${line%%=*}|"
   done
   echo "${string:0:-1})"
 }


# when TAB entered on an empty commmand line: complete directories and warp points
# when TAB entered on an command line only containing './': complete executable files
# # else: nomeal completion
zstyle -e ':completion::*:-command-::' tag-order \
'
    if [[ -z $PREFIX$SUFFIX ]]; then
      reply=( "local-directories:-normal local-directories:-warp:warp\ point" - )
    elif [[ $PREFIX$SUFFIX =~ ^./ ]]; then
      reply=( executables:Executables:Executables - )
    else
      reply=( )
    fi
'

# add warp points to the completions
zstyle ':completion::*:-command-::local-directories-warp' fake-always $(_warp_point_names_space_separated)
zstyle ':completion::*:-command-::local-directories-warp' ignored-patterns '*~$(_warp_point_names_pipe_separated)'

# add description to warp points on an empty line
zstyle -e ':completion::*:-command-::local-directories-warp' format '
if [[ -z $PREFIX$SUFFIX ]]; then
  reply=( "${SOLARIZED_COLORS[base2]}
 === ${FONT[bold]}%d${FONT[normal]} ===$RESET" )
fi
'

# color warp points
zstyle ':completion::*:-command-::local-directories-warp' list-colors "=$(_warp_point_names_pipe_separated)=38;2;181;137;0"
