# ==== stay save ====
alias rm='rm -iv --preserve-root'          # always ask before removing, preserve root directory and show deleted files/directories
alias mv='mv -iv'                          # always ask before moving and show moved files/directories
alias cp='cp -iv'                          # always ask before copying and show copied files/directories
alias ln='ln -iv'                          # always ask before linking and show linked files/directories

# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'