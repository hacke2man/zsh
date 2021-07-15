source $HOME/.config/zsh/functions.zsh
zsh_add_file env.zsh
zsh_add_file vim-mode.zsh
zsh_add_file prompt.zsh
zsh_add_file alias.zsh
zsh_add_file comp.zsh

autoload -Uz compinit
compinit
compdef _git con
zstyle ':completion:*' menu select
bindkey -a 'k' history-beginning-search-backward
bindkey -a 'j' history-beginning-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

zmodload zsh/zpty
zsh_add_plugin zsh-users/zsh-autosuggestions
zsh_add_plugin zsh-users/zsh-syntax-highlighting

() {
  leader_widget() {
    local leader_exit leader_next
    leader_next=$(SHELL=/bin/zsh BUFFER=$BUFFER CURSOR=$CURSOR leader print)
    leader_exit=$?
    zle reset-prompt
    if [ $leader_exit -eq 3 ]; then
        BUFFER="${BUFFER}${KEYS}"
        CURSOR=$((CURSOR + $#KEYS))
        return "$leader_exit"
    fi
    eval "$leader_next"
  }

  zle -N leader_widget
  bindkey -a ' ' leader_widget
}
