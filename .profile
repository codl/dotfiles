export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
export PAGER="most"
export MPD_MUSIC_DIR="$HOME/music"

[[ $TTY == '/dev/tty1' && $DISPLAY == '' ]] && exec startx
