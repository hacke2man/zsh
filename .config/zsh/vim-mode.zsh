# bindkey -e will be emacs mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect '^h' vi-backward-char
# bindkey -M menuselect '^k' vi-up-line-or-history
# bindkey -M menuselect '^l' vi-forward-char
# bindkey -M menuselect '^j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

function _cdf() {
  zle kill-whole-line
    zle vi-open-line-below
    cdf
    zle accept-line
}
zle -N _cdf
bindkey "^F" _cdf
bindkey -a "^F" _cdf
bindkey -a "z" _cdf

function _ef() {
    zle vi-open-line-below
    ef
    zle accept-line
}
zle -N _ef
bindkey "^E" _ef
bindkey -a "^E" _ef
bindkey -a "q" _ef

function _efs() {
    zle vi-open-line-below
    efs
    zle accept-line
}
stty stop undef
zle -N _efs
bindkey "^S" _efs
bindkey -a "^S" _efs


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

_cmdmode() {
  zle zle-line-init
  zle vim-cmd-mode
  zle accept-line
}

