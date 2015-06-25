zstyle ':completion:*' completer _complete _ignored _correct _prefix
zstyle :compinstall filename '/home/codl/.zshrc'
zstyle ':completion:*' max-errors 3

# disable XOFF and XON
unsetopt flowcontrol

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

PS1="%F{white}%S%1>>%n%<<@%1>>%m%<< %2~%s%F{black}%B$%b%f "
if [[ ! -z $SSH_CONNECTION ]]; then
    PS1="%F{green}%S%1>>%n%<<@%1>>%m%<< %2~%s%F{black}%B$%b%f "
fi

bindkey "\e[A" up-line-or-search
bindkey "\e[B" down-line-or-search

bindkey ${terminfo[khome]} beginning-of-line
bindkey ${terminfo[kend]} end-of-line
bindkey ${terminfo[kdch1]} delete-char

alias ginit='git init'

alias mvp='echo my mvp is mpv; mpv'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.z.sh" ]] && source "$HOME/.z.sh"
