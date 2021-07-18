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
      gitInfo="%F{238}% [%F{magenta}% ${gitInfo_branch}%F{238}% ]"
    else
      gitInfo="%F{238}% [%F{magenta}% ${gitInfo_branch}%F{238}% ]-[%F{red}% ${gitInfo_flags}%F{238}% ]"
    fi

  else
      gitInfo=""
  fi
}

setpromptformat()
{
  if [ -n "${gitInfo}" ]; then
    promptOne="
%F{238}% ┌${gitInfo}
└"
    else
      promptOne='
'
  fi
}

precmd() {
  setGitInfo
  setpromptformat
  autoload -Uz bindkey -a
}

setopt PROMPT_SUBST
PROMPT='${promptOne}%F{238}% [%F{yellow}% %c%F{238}% ]%?%F{foreground} '
