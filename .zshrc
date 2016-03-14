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

ps1_colors=(green cyan yellow blue magenta)
col_num=$[16#$(hostname | md5sum | head -c15) % ${#ps1_colors} + 1]
ps1_color=$ps1_colors[$col_num]

PS1="%F{${ps1_color}}%S%3>>%m%<< %2~%s%F{black}%B$%b%f "

unset ps1_colors ps1_color col_num

bindkey "\e[A" up-line-or-search
bindkey "\e[B" down-line-or-search

bindkey ${terminfo[khome]} beginning-of-line
bindkey ${terminfo[kend]} end-of-line
bindkey ${terminfo[kdch1]} delete-char

alias ginit='git init'

alias mvp='echo my mvp is mpv; mpv'
alias vim='nvim'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.z.sh" ]] && source "$HOME/.z.sh"
