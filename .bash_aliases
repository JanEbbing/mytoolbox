alias emcas='emacs' # Common typo on my keyboard at work for some reason

# Colorful grep
alias grep='grep --color=auto'
# Colorful LS
alias ls='ls --color=auto'
# Use a long listing format
alias ll='ls -la' 
# Show hidden files
alias l.='ls -d .* --color=auto'

#Git
alias gadp='git add -p'
alias gco='git checkout'
alias gpd='git push downstream'

#Dlog
alias dgadp='dlog git add -p'
alias dgco='dlog git checkout'
alias dpyt='dlog py.test'

#Utility
alias r='fc -s'
alias fhere='find . -name ' # Usage: fhere "myfile.txt"

# Ask before overwriting
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

# Protect the / directory
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias android-disconnect="fusermount -u /mnt/a" # Oneplus Two mount aliases
