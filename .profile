export PATH="$HOME/bin:$PATH"
export EDITOR="nvim"
export PAGER="most"
export MPD_MUSIC_DIR="$HOME/music"
export VISUAL="atom -w"

if [[ -f ~/.profile.credentials ]]; then
    source ~/.profile.credentials
fi

if [[ $(pgrep -x squid | wc -l) -gt 0 ]]; then
    export http_proxy="http://127.0.0.1:3128"
    export https_proxy="http://127.0.0.1:3128"
fi

if [[ $TTY == '/dev/tty1' && $DISPLAY == '' ]] && which startx > /dev/null 2>&1; then
    startx
    exit
fi
