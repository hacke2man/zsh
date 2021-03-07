
# PROMPT=$'%{$fg[green]%}┌[%{$fg_bold[white]%}%n%{$reset_color%}%{$fg[green]%}@%{$fg_bold[white]%}%m%{$reset_color%}%{$fg[green]%}] %{$(git_prompt_info)%}%(?,,%{$fg[green]%}[%{$fg_bold[white]%}%?%{$reset_color%}%{$fg[green]%}])
# %{$fg[green]%}└[%{$fg_bold[white]%}%~%{$reset_color%}%{$fg[green]%}]>%{$reset_color%} '
# PS2=$' %{$fg[green]%}|>%{$reset_color%} '

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$fg_bold[white]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[green]%}] "
# ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[green]%}⚡%{$reset_color%}"
# User configuration

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

# xmodmap -e "clear lock"
# xmodmap -e "keycode 9 = Caps_Lock"
# xmodmap -e "keycode 23 = Escape"
# xmodmap -e "keycode 66 = Tab"

source $HOME/.config/dotfiles/functions
source /usr/share/nvm/init-nvm.sh
eval "$(starship init zsh)"
