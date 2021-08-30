# Fuctions

edit(){
  $EDITOR $@
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
  read history_search
  grep --color $history_search  ~/.local/share/zsh/history
}

findg() {
  fd '^config$' --type f $HOME --hidden --one-file-system --no-ignore-vcs |
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

battery() {
  supply=`cat /sys/class/power_supply/BAT0/capacity`
  if grep Charging -q /sys/class/power_supply/BAT0/status ; then
    echo \*$supply
  else
    echo $supply
  fi
}

find_file() {
  if [ -n "${1}" ]; then
    tempPath="${1}"
  else
    tempPath="."
  fi

  fd . --type f --one-file-system --hidden --exclude .git |
    fzy
}

find_dir() {
  fd . --type d --one-file-system --hidden --exclude .git |
    fzy
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
