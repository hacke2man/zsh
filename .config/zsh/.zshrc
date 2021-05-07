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
alias config='/usr/bin/git --git-dir=$HOME/.git/ --work-tree=$HOME'
alias dmenu="dmenu -fn iosevka -nb #282828 -nf #d5c4a1 -sb #fabd2f -sf #ebdbb2"
alias website="ssh -i ~/.local/share/ssh/id_rsa root@pop-stack.org"
source $HOME/.config/zsh/functions

autoload -U compinit
compinit

source $HOME/.config/zsh/antigen.zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jeffreytse/zsh-vi-mode
antigen apply
ZVM_CURSOR_STYLE_ENABLED=false

setGitInfo() {
  if [ -d .git ] ; then
    gitInfo_branch=`git --git-dir=$PWD/.git --work-tree=$PWD branch | grep \* | cut -d" " -f2`
    gitInfo_unstaged=`git --git-dir=$PWD/.git --work-tree=$PWD status -s | grep "^.\S" -q && echo \!`
    gitInfo_staged=`git --git-dir=$PWD/.git --work-tree=$PWD status -s | grep "^\S." -q && echo \+`
    gitInfo_stash=`git --git-dir=$PWD/.git --work-tree=$PWD stash list | grep "\S*" -q && echo $`
    gitInfo_unpushed=`git --git-dir=$PWD/.git --work-tree=$PWD status | grep -q "ahead" && echo \^`
    gitInfo_flags=${gitInfo_staged}${gitInfo_unstaged}${gitInfo_stash}${gitInfo_unpushed}
    if [ "${gitInfo_flags}" = "" ] ; then
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
