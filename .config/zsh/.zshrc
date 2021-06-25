source $HOME/.config/zsh/functions.zsh
zsh_add_file prompt.zsh
zsh_add_file alias.zsh
zsh_add_file vim-mode.zsh
zsh_add_file comp.zsh

autoload -Uz compinit
compinit
compdef _git con
zstyle ':completion:*' menu select
# bindkey '\e[A' history-search-backward
# bindkey '\e[B' history-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

zmodload zsh/zpty
zsh_add_plugin zsh-users/zsh-autosuggestions
zsh_add_plugin zsh-users/zsh-syntax-highlighting
