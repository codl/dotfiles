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
[[ -f $HOME/.xinput.sh ]] && (sleep 5; bash $HOME/.xinput.sh) &
[[ -f $HOME/.xmodmap ]] && (sleep 5; xmodmap $HOME/.xmodmap) &

setxkbmap fr -option compose:menu
xbindkeys
xset s off

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

redshift -l 48:4.1 &

(
    sleep 10
    ibus-daemon -drx
    syncthing-gtk &
    [[ -e /bin/sonata ]] && sonata --hidden
)&

x11vnc -rfbauth ~/.x11vnc/passwd -display $DISPLAY -forever -o /dev/null -bg -nobell

exec ${WM:-startxfce4}
