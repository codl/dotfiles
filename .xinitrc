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

setxkbmap fr -option compose:menu
xbindkeys
xset s off

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

redshift-gtk -l 48:-4.1 &

(
    sleep 10
    [[ -f $HOME/.xmodmap ]] && xmodmap $HOME/.xmodmap
    ibus-daemon -drx
    syncthing-gtk &
    [[ -e /bin/sonata ]] && sonata --hidden
)&

(
    sleep 30
    bash $HOME/.xfce4-panel-fix
) &

x11vnc -usepw -display $DISPLAY -N -forever -o /dev/null -bg -nobell -ncache 2

[[ -e /bin/oneko ]] && oneko --tofocus &

exec ${WM:-startxfce4}
