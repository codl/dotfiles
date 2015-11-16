if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

[[ -f $HOME/.xrandr.sh ]] && source $HOME/.xrandr.sh
[[ -f $HOME/.xinput.sh ]] && source $HOME/.xinput.sh

setxkbmap fr -option compose:menu
xmodmap $HOME/.xmodmap
xbindkeys

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

redshift -l 48:4.1 &

compton --config .compton.conf &

(
    sleep 5
    dropbox &
    ibus-daemon -drx
)&

exec ${WM:-herbstluftwm}
