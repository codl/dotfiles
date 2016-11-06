export PATH="$HOME/bin:$PATH"
if [[ -e /bin/ruby ]]; then
    export PATH="$PATH:$(/bin/ruby -rubygems -e "puts Gem.user_dir")/bin"
fi
export EDITOR="nvim"
export PAGER="most"
export MPD_MUSIC_DIR="$HOME/media/music"

if [[ -f ~/.profile.credentials ]]; then
    source ~/.profile.credentials
fi
