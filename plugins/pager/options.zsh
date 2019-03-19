# ==== colorfull man pages ====

export PAGER=less

export LESS_TERMCAP_mb=$'\e[1;31m'        # begin blinking
export LESS_TERMCAP_md=$'\e[1;38;5;136m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;254m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[4;38;5;64m'   # begin underline