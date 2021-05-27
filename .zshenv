export HISTFILE="$XDG_DATA_HOME"/zsh/history
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/bin:$HOME/Scripts

export ZDOTDIR=$HOME/.config/zsh
source $HOME/.config/dotfiles/zshThisComp 2> /dev/null
export HISTFILE=$XDG_DATA_HOME/zsh/history
export SAVEHIST=999999999
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#665c54"

export EDITOR=nvim
export MANPAGER="nvim +'Man! | set scrolloff=999 | normal M'"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--reverse --height=50%'
export BAT_THEME=gruvbox-dark
export GITHUB_NAME="r1ri"

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export BROWSER=/bin/brave
