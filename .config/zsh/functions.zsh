#!/bin/sh
# Fuctions

la()
{
  exa -la --group-directories-first --git --color=always $@ | cut -d: -f2 | sed 's/^..//'
}

color_files()
{
  cat -|
  while read line
  do
    type=`ls -l $line|`
    if []
    echo -n "$line " |colorOnce 34
  done
}

g(){
    git status --short
    git stash list
    echo -n [ | colorOnce 32
    git branch --color --show-current | tr -d \\n
    echo -n "] " | colorOnce 32
  read TEMP
  while [[ $TEMP != "q" ]]
  do
    echo $TEMP | sed "s/^/git /" | tr -d \\n | sh
    echo ""
    git status --short
    git stash list
    echo -n [ | colorOnce 32
    git branch --color --show-current | tr -d \\n
    echo -n "] " | colorOnce 32
    read -r TEMP
  done
}

function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then 
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

his() {
  tempfzfcommand=`cat ~/.local/share/zsh/history | fzf`
  if [ -n "$tempfzfcommand" ]; then
    eval $tempfzfcommand
  else
    echo no selection
  fi
}

findg() {
  fd . $HOME --hidden --exclude .cache | grep "\.git/config$" |
    xargs grep $GITHUB_NAME -m 1 | sed "s/\.git.*/.git/"
}

checkGit() {
  findg |
  while read line
  do
    if echo $line | grep dotfiles.git -q ; then
      workArea=$HOME
    else
      workArea=`echo $line | sed "s/\/\.git//"`
    fi

    echo $workArea | grep -o "[^/]\+$" | colorOnce 35
    git --git-dir=$line --work-tree=$workArea status -b -s
    echo
  done
}

las() {
  lsResult=`ls -lhAF $1 |
    sed "1 d; s/^\S* //; s/\s*[0-9]\+//; s/ liam//; s/ [A-Z].*:[0-9][0-9]//; /\// d"`

  du -hd 1 | sed "/\.$/ d; s/\s\.\// /; /^\S\S\S / s/^/ /; s/^/ /" | colorOnce 34
  echo $lsResult
}

battery() {
  supply=`cat /sys/class/power_supply/BAT0/capacity`
  if grep Charging -q /sys/class/power_supply/BAT0/status ; then
    echo \*$supply
  else
    echo $supply
  fi
}

home(){
  if tmux ls | grep -q home ; then
    tmux attach -t 'home'
  else
    tmux new-session -d
    tmux rename-session 'home'
    tmux attach-session
  fi
}

attachedToTmux() {
  [ -z ${TMUX} ]
}

ff() {
  if [ -n "${1}" ]; then
    tempPath="${1}"
  else
    tempPath="."
  fi

  fd . --hidden --type f --ignore-file ~/.gitignore |
    fzy
}

fDir() {
  fd . --hidden --type d --base-directory ~/ --ignore-file=$HOME/.gitignore |
    fzy
  # fd . --hidden --type d --ignore-file=$HOME/.gitignore |
  #   fzf --layout=reverse --height=50%
}

fs(){
  # RG_PREFIX="rg --hidden -n --ignore-file $HOME/.gitignore | fzy --show-matches="
  #   echo | fzf --bind "change:reload:$RG_PREFIX {q} | fzy --show-matches={q} || true" \
  #   --ansi --disabled
  rg . --hidden -n --ignore-file $HOME/.gitignore | fzy
}

ef() {
  if [ -n "${1}" ]; then
    argPath="${1}"
  else
    argPath="."
  fi

  tempfzfpath=`ff $argPath`
  if [ -z ${tempfzfpath} ]; then
    echo -n exit no selection
  else
    echo -n $tempfzfpath
    if attachedToTmux ; then
      $EDITOR $tempfzfpath
    else
      tmux new-window $EDITOR $tempfzfpath
    fi
  fi
}

fe() {
  tempfzfpath=`fd . --hidden --type f | fzf --layout=reverse --height=50%`
  if [ -z $1 ]; then
    echo $tempfzfpath
  else
    $1 $tempfzfpath
  fi
}

cdf() {
  tempfzfpath=`fDir`
  if [ -n "$tempfzfpath" ]; then
    echo -n $tempfzfpath
    cd $tempfzfpath
  else
    echo -n exit no selection
  fi
}

cdg() {
  tempfzfpath=`findg | sed 's@'"${HOME}"'/@@' | sed 's/\/\.git//' |
    fzf --layout=reverse --height=50% `
  if [ -n "$tempfzfpath" ]; then
    echo $tempfzfpath
    cd $HOME/$tempfzfpath
  else
    echo exit no selection
  fi
}

mvf() {
  tempfzfpath1=`ff`
  tempfzfpath2=`fDir`
  if [ -n "$tempfzfpath1" ] && [ -n "$tempfzfpath2" ]; then
    echo "move ${tempfzfpath1} to ${tempfzfpath2}"
    mv $tempfzfpath1 $tempfzfpath2
  else
    echo -n exit no selection
  fi
}

tmf() {
  tempfzfpath=`fDir`
  if [ -z ${tempfzfpath} ]; then
    echo exit no selection
  else
    echo $tempfzfpath
    if attachedToTmux ; then
      tmux new-session -c $tempfzfpath
    else
      tmux new-window -c $tempfzfpath
    fi
  fi
}

efs() {
  tempfzfpath=`fs`
  if  [ -n "$tempfzfpath" ]; then
    echo -n $tempfzfpath
    $EDITOR `echo $tempfzfpath | cut -d: -f1` +`echo $tempfzfpath | cut -d: -f2`
  else
    echo -n no selection
  fi
}
