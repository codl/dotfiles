export PATH="$HOME/bin:$PATH"
export EDITOR="vim"
export PAGER="most"
export MPD_MUSIC_DIR="$HOME/music"

[[ $(pgrep -x squid | wc -l) -gt 0 ]] && export http_proxy="127.0.0.1:3128"

[[ $TTY == '/dev/tty1' && $DISPLAY == '' ]] && exec startx
