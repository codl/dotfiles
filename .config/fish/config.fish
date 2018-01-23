if status --is-login
    exec bash -l -c "source ~/.profile; exec fish -i"
end

if status --is-interactive; and test -d $HOME/.rbenv
    set -x PATH $HOME/.rbenv/bin $PATH
    source (rbenv init -|psub)
end
