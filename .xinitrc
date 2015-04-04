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

[[ -f $HOME/.xrandr.sh ]] && source $HOME/.xrandr.sh
[[ -f $HOME/.wacom.sh ]] && source $HOME/.wacom.sh

setxkbmap fr -option compose:menu
xmodmap $HOME/.xmodmap
xbindkeys

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

redshift -l 48:4.1 &

compton --config .compton.conf &

exec ${WM:-herbstluftwm}
