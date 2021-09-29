alias ls="ls --color --group-directories-first"
alias cam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias e="edit"
alias sdm='switch_dev_vim_mode'
alias m="neomutt"
alias updatebar="pkill -47 dwmblocks"
alias put="xclip -select clipboard -o"
alias pkup="nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
alias clear="clear && echo"
alias cpy="xclip -select clipboard"
alias reboot='sudo /usr/bin/systemctl reboot'
alias pacman="sudo pacman"
alias g='git'
alias tst="make && ./a.out"
alias yank="xclip -select clipboard"
alias home="abduco -A home zsh"
