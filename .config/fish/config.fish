if status --is-login
    exec bash -l -c "source ~/.profile; exec fish -i"
end

if status --is-interactive
    #ametameric -r

    if test -d $HOME/.rbenv
        set -x PATH $HOME/.rbenv/bin $PATH
        source (rbenv init -|psub)
    end
end

# path mangling
contains $HOME/.cargo/bin $PATH; or set -p PATH $HOME/.cargo/bin
contains $HOME/.local/bin $PATH; or set -p PATH $HOME/.local/bin
contains $HOME/bin $PATH; or set -p PATH $HOME/bin

# variables
type -q nvim; and set -x EDITOR nvim
type -q most; and set -x PAGER most

type --query direnv; and direnv hook fish | source
type --query pyenv; and pyenv init - | source
type --query zoxide; and zoxide init fish | source
