# bindkey -e will be emacs mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect '^h' vi-backward-char
# bindkey -M menuselect '^k' vi-up-line-or-history
# bindkey -M menuselect '^l' vi-forward-char
# bindkey -M menuselect '^j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char
bindkey -a 'k' history-beginning-search-backward
bindkey -a 'j' history-beginning-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
# bindkey -ar 'm'

# getc is litterally int main(){ int c = getchar(); printf("%s",c); }
leader_widget() {
  getc < /dev/tty | read char
  case $char in
    'f')
      zle vi-open-line-below
      edit_find

      zle kill-whole-line
      precmd
      zle reset-prompt
      zle -K vicmd
      ;;
    'g')
      zle vi-open-line-below
      fzftemppath=`findg | sed "s|\$HOME|~|"| fzf`
      eval "cd $fzftemppath"

      zle kill-whole-line
      precmd
      zle reset-prompt
      zle -K vicmd
      ;;
    's')
      zle vi-open-line-below
      edit_find_string

      zle kill-whole-line
      precmd
      zle reset-prompt
      zle -K vicmd
      ;;
    'd')
      zle kill-whole-line
      zle vi-open-line-below
      cd_find

      zle kill-whole-line
      precmd
      zle reset-prompt
      zle -K vicmd
      ;;
    'l')
      zle kill-whole-line
      zle vi-open-line-below
      listfiles --group-directories-first --color
      zle kill-whole-line
      zle accept-line
      ;;
    'e')
      zle kill-whole-line
      PASTE="e "
      LBUFFER="$LBUFFER${RBUFFER:0:1}"
      RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
      zle vi-end-of-line
      zle -K viins
      ;;
    'b')
      cd ..
      zle reset-prompt
      ;;
    'c')
      zle kill-whole-line
      PASTE="cd "
      LBUFFER="$LBUFFER${RBUFFER:0:1}"
      RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
      zle vi-end-of-line
      zle -K viins
      ;;
    'q')
      exit
      ;;
    'z')
      $EDITOR +"norm '0"
      ;;
  esac
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
  zle -K vicmd
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() {
  echo -ne '\e[5 q';
} # Use beam shape cursor for each new prompt.

# Yank to the system clipboard
function u-vi-yank {
  zle vi-yank
  echo -ne "$CUTBUFFER" | xclip -selection clipboard
}
zle -N u-vi-yank
bindkey -a "y" u-vi-yank

function u-vi-delete {
  zle vi-delete
  echo -ne "$CUTBUFFER" | xclip -selection clipboard
}
zle -N u-vi-delete
bindkey -a "d" u-vi-delete

function u-vi-change {
  zle vi-change
  echo -ne "$CUTBUFFER" | xclip -selection clipboard
}
zle -N u-vi-change
bindkey -a "c" u-vi-change

x-paste() {
    PASTE=$(xclip -selection clipboard -o)
    LBUFFER="$LBUFFER${RBUFFER:0:1}"
    RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
}
zle -N x-paste
bindkey -M vicmd "p" x-paste
