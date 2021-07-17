# bindkey -e will be emacs mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect '^h' vi-backward-char
# bindkey -M menuselect '^k' vi-up-line-or-history
# bindkey -M menuselect '^l' vi-forward-char
# bindkey -M menuselect '^j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

leader_widget() {
  $HOME/dev/getc/getc < /dev/tty | read char
  case $char in
    'e')
      $HOME/dev/getc/getc < /dev/tty | read char
      case $char in
        'f')
        zle vi-open-line-below
        ef
        ;;
      's')
        zle vi-open-line-below
        efs
      esac
      ;;
    'f')
      zle kill-whole-line
      zle vi-open-line-below
      cdf
      ;;
  esac
  zle accept-line
}
zle -N leader_widget
bindkey -a ' ' leader_widget

# Change cursor shape for different vi modes.
function zle-keymap-select () {
   case $KEYMAP in
      vicmd) echo -ne '\e[1 q';;      # block
      viins|main) echo -ne '\e[5 q';; # beam
   esac
}

zle -N zle-keymap-select

zle-line-init() {
   zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
   echo -ne "\e[5 q"
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Yank to the system clipboard
function vi-yank-xclip {
    zle vi-yank
   echo "$CUTBUFFER" | xclip -selection clipboard
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip

(){
  _cmdmode() {
   zle vim-cmd-mode
  }
}
