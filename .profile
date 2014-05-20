[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/bin:$PATH"
export GOPATH=$HOME/go
export EDITOR="vim"
export PAGER="most"

[[ $TTY == '/dev/tty1' && $DISPLAY == '' ]] && exec startx
