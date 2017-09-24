export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
if [[ -e /bin/ruby ]]; then
    export PATH="$PATH:$(/bin/ruby -rubygems -e "puts Gem.user_dir")/bin"
fi
export EDITOR="nvim"
export PAGER="most"
export MPD_MUSIC_DIR="$HOME/media/music"

export XDG_DESKTOP_DIR="$HOME/.fuck"
export XDG_DOCUMENTS_DIR="$HOME/.fuck"
export XDG_DOWNLOAD_DIR="/tmp"
export XDG_MUSIC_DIR="$HOME/media/music"
export XDG_PICTURES_DIR="$HOME/images"
export XDG_PUBLICSHARE_DIR="$HOME/.fuck"
export XDG_TEMPLATES_DIR="$HOME/.fuck/what even is templates"
export XDG_VIDEOS_DIR="$HOME/media"

if [[ -f ~/.profile.credentials ]]; then
    source ~/.profile.credentials
fi
