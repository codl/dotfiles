# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate _prefix
zstyle :compinstall filename '/home/codl/.zshrc'

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

bindkey "\e[A" up-line-or-search
bindkey "\e[B" down-line-or-search

bindkey ${terminfo[khome]} beginning-of-line
bindkey ${terminfo[kend]} end-of-line
bindkey ${terminfo[kdch1]} delete-char
