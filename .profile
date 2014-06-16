export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
export PAGER="most"
export MPD_MUSIC_DIR="$HOME/music"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ $TTY == '/dev/tty1' && $DISPLAY == '' ]] && exec startx
