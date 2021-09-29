source $HOME/.config/zsh/functions.zsh
zsh_add_file env.zsh
zsh_add_file prompt.zsh
zsh_add_file alias.zsh
zsh_add_file comp.zsh
zsh_add_file vim-mode.zsh

autoload -Uz compinit
compinit
compdef _git con
zstyle ':completion:*' menu select


zmodload zsh/zpty
zsh_add_plugin zsh-users/zsh-autosuggestions
zsh_add_plugin zsh-users/zsh-syntax-highlighting
echo
set_title "zsh" "$PPID"
