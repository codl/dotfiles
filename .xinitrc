if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export GTK_IM_MODULE=uim
export QT_IM_MODULE=uim
uim-xim &
uim-toolbar-gtk-systray &
export XMODIFIERS=@im=uim


setxkbmap fr -option compose:menu
xmodmap $HOME/.xmodmap
xbindkeys
{
    sleep 5
    keepassx &
} &
compton --config .compton.conf &

#pulseaudio --start &

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

redshift -l 48:4.1 &

exec ${WM:-herbstluftwm}
