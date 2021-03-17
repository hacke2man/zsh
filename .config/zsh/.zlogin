export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

export HISTFILE="$XDG_DATA_HOME"/zsh/history

export STARSHIP_CONFIG=~/.config/dotfiles/starship.toml
source /usr/share/nvm/init-nvm.sh
