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

export PATH=$PATH:$HOME/.local/bin:$HOME/.local/bin:/home/liam/Scripts
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export BROWSER=/usr/bin/brave
export EDITOR=nvim
export MANPAGER="sh -c 'col -b | bat -p -l man --style numbers'"
export BAT_THEME=gruvbox

# Fuctions

cdf() {
  tempfzfpath=`fd --hidden -t d . | fzf --layout=reverse --preview 'ls -a --group-directories-first --color {} | head -30 |tail -n +3'`

  cd $tempfzfpath
}

tmf() {
  tempfzfpath=`fd --hidden -t d . | fzf --layout=reverse --preview 'ls -a --group-directories-first --color {} | head -30 |tail -n +3'`

  tmux new-window -c $tempfzfpath
}


ef() {
  tempfzfpath=`ag --hidden --ignore .git -g ""| fzf --layout=reverse --preview 'bat --style numbers,changes --color=always --theme gruvbox {}| head -200'`

  nvim $tempfzfpath
}


tmef() {
  tempfzfpath=`ag --hidden --ignore .git -g ""| fzf --layout=reverse --preview 'bat --style numbers,changes --color=always --theme gruvbox {}| head -200'`

  tmux new-window nvim $tempfzfpath
}

# xmodmap -e "clear lock"
# xmodmap -e "keycode 9 = Caps_Lock"
# xmodmap -e "keycode 23 = Escape"
# xmodmap -e "keycode 66 = Tab"


_comp_option+=(globdots)
pfetch
