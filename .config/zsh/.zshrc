alias clear="clear && pfetch"
alias ls="ls -vG --color --group-directories-first"
alias la="ls -A1"
alias tmls="tmux ls"
alias tmrn="tmux new-window ranger"
alias cam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias e=$EDITOR
alias m="neomutt"
alias vifm="vifmrun"
alias sourcefunc="source ${HOME}/.config/zsh/functions"
alias dmenu="dmenu -fn iosevka -nb #282828 -nf #d5c4a1 -sb #fabd2f -sf #ebdbb2"
alias website="ssh -i ~/.local/share/ssh/id_rsa root@pop-stack.org"
alias con="git --work-tree=$HOME --git-dir=$HOME/.git"
alias fixmon="xrandr --output DVI-D-1 --off --output DP-1 --off --output DP-2 --off --output HDMI-1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-3 --primary --mode 1920x1080 --pos 0x0 --rotate normal"
source $HOME/.config/zsh/functions

autoload -U compinit
compinit

source $HOME/.config/zsh/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply 2>/dev/null
ZVM_CURSOR_STYLE_ENABLED=false

setGitInfo() {
  if [ -f .git ]; then
    export gwt=$PWD
    export gdir=`cat .git | cut -d' ' -f2`
  elif [ -d .git ]; then
    export gwt=$PWD
    export gdir="$PWD/.git"
  else
    unset gdir
  fi

  if [ -n "$gdir" ]; then
    gitInfo_branch=`git --git-dir=$gdir --work-tree=$gwt branch | grep \* | cut -d" " -f2`
    gitInfo_unstaged=`git --git-dir=$gdir --work-tree=$gwt status -s | grep "^.\S" -q && echo \!`
    gitInfo_staged=`git --git-dir=$gdir --work-tree=$gwt status -s | grep "^\S." -q && echo \+`
    gitInfo_stash=`git --git-dir=$gdir --work-tree=$gwt stash list | grep "\S*" -q && echo $`
    gitInfo_unpushed=`git --git-dir=$gdir --work-tree=$gwt status | grep -q "ahead" && echo \^`
    gitInfo_flags=${gitInfo_staged}${gitInfo_unstaged}${gitInfo_stash}${gitInfo_unpushed}
    if [ "${gitInfo_flags}" = "" ]; then
      gitInfo="%F{238}% ┌[%F{magenta}% ${gitInfo_branch}%F{238}% ]
└"
    else
      gitInfo="%F{238}% ┌[%F{magenta}% ${gitInfo_branch}%F{238}% ]-[%F{red}% ${gitInfo_flags}%F{238}% ]
└"
    fi

  else
      gitInfo=""
  fi
}

precmd() {
  setGitInfo
}

setopt PROMPT_SUBST
PROMPT='
${gitInfo}%F{238}% [%F{yellow}% %c%F{238}% ]%?%F{foreground} '
