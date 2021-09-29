export LC_CTYPE=en_CA.UTF-8
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DESKTOP_DIR=$HOME/desk
export PATH=$PATH:$HOME/.local/bin:$HOME/.local/bin:$HOME/scr
export DRPATH=$XDG_DATA_HOME/dmrun

export ZDOTDIR=$HOME/.config/zsh
export FPATH=$HOME/.config/zsh:$FPATH
export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
export HISTFILE=$XDG_DATA_HOME/zsh/history
export SAVEHIST=999999999

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#665c54"
export MANPAGER="nvim +'Man! | set scrolloff=999 | normal M'"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--reverse --height=50%'
export FZF_DEFAULT_OPTS='
--reverse --height=50%
--color=fg:#ebdbb2,bg:#282828,hl:#504945 
--color=fg+:#ebdbb2,bg+:#282828,hl+:#504945 
--color=info:#fabd2f,prompt:#8ec07c,pointer:#b16286
--color=marker:#b16286,spinner:#fabd2f,header:#458588
--ansi
--bind=tab:down,shift-tab:up+unbind:shift-tab
'
export BAT_THEME=gruvbox-dark
export GITHUB_NAME="r1ri"
export QT_QPA_PLATFORMTHEME="qt5ct"

export EDITOR=nvim
export BROWSER=/bin/brave
export TERM="screen-256color"
