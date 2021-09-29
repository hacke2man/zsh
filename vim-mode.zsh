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
autoload edit-command-line
zle -N edit-command-line
bindkey -a "^E" edit-command-line

function zle-line-finish()
{
  echo $BUFFER >> ~/.local/share/zsh/history
  lua ~/scr/helper/insertUnique.lua ~/.local/share/zsh/history > /tmp/zshhist
  mv /tmp/zshhist ~/.local/share/zsh/history
  fc -R
}
zle -N zle-line-finish

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) RPROMPT_MODE="%F{238}[normal]";;      # NORMAL mode
        viins|main) RPROMPT_MODE="%F{238}[insert]";; # INSERT mode
    esac
    zle reset-prompt
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K vicmd
    export RPROMPT_MODE="%F{238}[normal]"
    zle reset-prompt
}
zle -N zle-line-init
# zle-line-init() {

# getc is litterally int main(){ int c = getchar(); printf("%s",c); }
leader_widget() {
  getc < /dev/tty | read char
  case $char in
    'f')
      run_in_place edit_find
      ;;
    'g')
      run_in_place fzftemppath=`findg | sed "s|\$HOME|~|"| fzf` &&\
        eval "cd $fzftemppath"
      ;;
    's')
      run_in_place edit_find_string
      ;;
    'd')
      run_in_place cd_find
      ;;
    'p')
      run_in_place launch_programs
      ;;
    'b')
      run_in_place cd ..
      ;;
    'l')
      run_in_place follow_mfm
      ;;
    'e')
      zle kill-whole-line
      PASTE="e "
      LBUFFER="$LBUFFER${RBUFFER:0:1}"
      RBUFFER="$PASTE${RBUFFER:1:${#RBUFFER}}"
      zle vi-end-of-line
      zle -K viins
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
      xdotool key ctrl+o
      exit
      ;;
    'z')
      $EDITOR +"norm '0"
      ;;
  esac
}
zle -N leader_widget
bindkey -a ' ' leader_widget

function follow_mfm()
{
  mfm_path="$PWD"
  mfm_backup_path=""
  while [ -n "$mfm_path" ]; do
    mfm_path=`minifm $mfm_path </dev/tty`
    [ -f "$mfm_path" ] && edit $mfm_path
    if [ -d "$mfm_path" ] && cd $mfm_path
    [ -n "$mfm_path" ] && mfm_path="$PWD"
  done
}

function run_in_place()
{
  zle kill-whole-line
  zle vi-open-line-below
  $@
  zle kill-whole-line
  precmd
  zle reset-prompt
  zle -K vicmd
}

function clear-screen {
  clear
  zle reset-prompt
}
zle -N clear-screen

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
