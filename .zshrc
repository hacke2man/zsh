alias et="exit"
alias clear="clear && pfetch"
alias la="exa -la --group-directories-first"
alias ls="ls -vG --color --group-directories-first"
alias tmls="tmux ls"
alias tmrn="tmux new-window ranger"
alias cam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias e=$EDITOR
alias m="neomutt"
alias vifm="vifmrun"

eval "$(starship init zsh)"
