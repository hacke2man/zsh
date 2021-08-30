[ -d $XDG_DATA_HOME/prompt ] || mkdir $XDG_DATA_HOME/prompt
[ -p $XDG_DATA_HOME/prompt/prompt_pipe ] || mkfifo $XDG_DATA_HOME/prompt/prompt_pipe

check_set()
{
  i=0
  while read line
  do
    setopt local_options no_notify no_monitor
    echo "[ -n \"\$$line\" ] && set_var=SUP" > $XDG_DATA_HOME/prompt/prompt_pipe 2>/dev/null &
    source $XDG_DATA_HOME/prompt/prompt_pipe

    [ -n "$set_var" ] && ((i=i+1))
    unset set_var
  done

  echo $i
}

formatpromptitem()
{
  setopt local_options no_notify no_monitor
  total=`echo $@ | sed "s/ /\n/g" | check_set`
  formatted=0
  formatted_plus_one=1
  i=0
  while [ $formatted -lt $total ]
  do
    echo "if [ -n \"\$${argv[((i+1))]}\" ]; then
    itemout=\$itemout\`echo \"%F{238}% [\$${argv[((i+1))]}%F{238}% ]\"\`
    isset=SET
    fi
    " > $XDG_DATA_HOME/prompt/prompt_pipe &
    source $XDG_DATA_HOME/prompt/prompt_pipe

    if [ $formatted_plus_one -lt $total ]
    then
      itemout="$itemout-"
    fi

    if [ -n "$isset" ]
    then
      ((formatted=formatted+1))
      ((formatted_plus_one=formatted+1))
      unset isset
    fi

    ((i=i+1))
  done
  echo $itemout
}

setGitInfo()
{
  gitInfo=""

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
    gitInfo_branch=`git --git-dir=$gdir --work-tree=$gwt branch |
      grep \* |
      cut -d" " -f2 | tr -d \\n`
    if [ "$gitInfo_branch" = "master" ]
    then
      unset gitInfo_branch
    else
      gitInfo_branch="%F{magenta}% $gitInfo_branch"
    fi

    gitInfo_unstaged=`git --git-dir=$gdir --work-tree=$gwt status -s |
      grep "^.\S" -q && echo \!`

    gitInfo_staged=`git --git-dir=$gdir --work-tree=$gwt status -s |
      grep "^\S." -q && echo \+`

    gitInfo_stash=`git --git-dir=$gdir --work-tree=$gwt stash list |
      grep "\S*" -q && echo $`

    gitInfo_unpushed=`git --git-dir=$gdir --work-tree=$gwt status |
      grep -q "ahead" && echo \^`

    gitInfo_flags="${gitInfo_staged}${gitInfo_unstaged}${gitInfo_stash}${gitInfo_unpushed}"
    [ -n "$gitInfo_flags" ] && gitInfo_flags="%F{red}% $gitInfo_flags"
    export gitInfo=`formatpromptitem gitInfo_branch gitInfo_flags`
  else
    unset gitInfo
  fi
}

setpromptformat()
{
  if [ -n "${gitInfo}" ]; then
    promptTwo="${gitInfo}-"
    else
      promptTwo=''
  fi
}

precmd() {
  setGitInfo
  setpromptformat
  unset gitInfo
}

setopt PROMPT_SUBST
PROMPT='${promptOne}%F{238}% [%F{yellow}% %c%F{238}% ]%?%F{foreground} '
RPROMPT='%F{green} ${promptTwo}${RPROMPT_MODE}'
setopt transient_rprompt
