alias clear="clear && pfetch"
alias la="ls -lAh --group-directories-first"
alias ls="ls -vG --color --group-directories-first"
alias tmls="tmux ls"
alias tmrn="tmux new-window ranger"
alias cam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias e=$EDITOR
alias m="neomutt"
alias vifm="vifmrun"
alias sourcefunc="source ${HOME}/.config/dotfiles/functions"

autoload -U compinit
compinit

source $HOME/.config/dotfiles/antigen.zsh
antigen bundle jeffreytse/zsh-vi-mode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

PROMPT='
%F{238}% %F{yellow}% %c%F{foreground}% :%F{238}% %?%F{foreground}%  '
