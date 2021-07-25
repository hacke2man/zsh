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
  fd '^config$' --type f $HOME --hidden --one-file-system --no-ignore-vcs --ignore-file=$HOME/.gitignore |
   grep ".git/[a-z]*$" | xargs rg $GITHUB_NAME -m 1 | sed "s/\.git.*/.git/" | sed "s/\/\.git//"
}

checkgit() {
  findg |
  while read line
  do
    echo $line | grep -o "[^/]\+$" | colorOnce 35
    git --git-dir=$line/.git --work-tree=$line status -b -s
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

find_file() {
  if [ -n "${1}" ]; then
    tempPath="${1}"
  else
    tempPath="."
  fi

  fd . --max-depth=1 --type f --one-file-system --hidden |
    fzf --bind "change:reload(fd {q} --hidden --one-file-system --type f --ignore-file=$HOME/.gitignore | fzy --show-matches={q} | head -50)" \
    --preview "bat --color=always --line-range :500 {}"\
}

find_dir() {
  fd . --max-depth=1 --type d --one-file-system --hidden |
    fzf --bind "change:reload(fd {q} --hidden --one-file-system --type d --ignore-file=$HOME/.gitignore | fzy --show-matches={q} | head -50)" \
    --preview "ls --color --group-directories-first -1A {}"\
}

find_string(){
  fd . --max-depth=1 --type f --one-file-system --hidden | sed "s/$/\:1/" |
    fzf --bind "change:reload(rg {q} --hidden --one-file-system -n --ignore-file=$HOME/.gitignore | fzy --show-matches={q} | head -100)" \
    --preview "batrg {}"\
}

edit_find() {
  if [ -n "${1}" ]; then
    argPath="${1}"
  else
    argPath="."
  fi

  tempfzfpath=`find_file $argPath`
  if [ -n "${tempfzfpath}" ]; then
    $EDITOR $tempfzfpath
  fi
}

cd_find() {
  tempfzfpath=`find_dir`
  if [ -n "$tempfzfpath" ]; then
    cd $tempfzfpath
  fi
}

edit_find_string() {
  tempfzfpath=`find_string`
  if  [ -n "$tempfzfpath" ]; then
    $EDITOR `echo $tempfzfpath | cut -d: -f1` +`echo $tempfzfpath | cut -d: -f2`
  fi
}
