# Path to your oh-my-zsh installation.
export ZSH="/home/liam/.oh-my-zsh"

ZSH_THEME="sap"



# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-vim-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration

alias et="exit"
alias clear="clear && pfetch"
alias la="exa -la --group-directories-first"
alias ls="ls --color --group-directories-first"
alias tmls="tmux ls"
alias rn="ranger"
alias tmrn="tmux new-window ranger"
alias cam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias e="nvim"
alias m="neomutt"
alias battery="cat /sys/class/power_supply/BAT0/capacity"
alias vifm="vifmrun"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='find . ""'
export EDITOR=nvim
export MANPAGER="sh -c 'col -b | bat -p -l man --style plain'"
export BAT_THEME=gruvbox
# these are the defaults

# xmodmap -e "clear lock"
# xmodmap -e "keycode 9 = Caps_Lock"
# xmodmap -e "keycode 23 = Escape"
# xmodmap -e "keycode 66 = Tab"


_comp_option+=(globdots)
source $HOME/.config/zsh/functions
