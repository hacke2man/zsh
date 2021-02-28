export PATH=$PATH:$HOME/.local/bin:$HOME/.local/bin:$HOME/.config/dotfiles/Scripts

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export HISTFILE="$XDG_DATA_HOME"/zsh/history

export BROWSER=/usr/bin/brave

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_COMMAND='find . ""'
export EDITOR=nvim
export MANPAGER="sh -c 'col -b | bat -p -l man --style plain'"
export BAT_THEME=gruvbox
