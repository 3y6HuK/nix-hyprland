fastfetch
df -h /
alias ex='export DISPLAY=:0.0'
alias pm='sudo pm-suspend'
alias cg='sudo nix-collect-garbage -d'
alias rec='ffmpeg -f alsa -i pulse -f x11grab -r 25 -s 1920x1080 -i :0+0,60 -acodec pcm_s16le -vcodec libx264 -threads 0 output.mkv'
alias ipi='curl smart-ip.net/myip'
alias ipmy='curl eth0.me'
alias moon="curl 'wttr.in/Moon'"
alias confnix='nvim ~/.nix/configuration.nix'
alias swap='sudo swapoff -a && sudo swapon -a && systemctl start /dev/zram0'
alias ipi='curl smart-ip.net/myip'
alias wtr='wget -O - wttr.in/"Khabarovsk" -q'
alias yt='ytfzf -t'
alias sn='sudo nano'
alias n='nano'
alias list="qlist -I | grep"
alias kino='sh ~/INSTALL/Torrserver/kino_test.sh'
alias sr='sudo ranger'
alias rg='ranger'
alias pw='pywalfox update'
alias kb='setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle'
alias v='nvim'
alias sv='sudo nvim'
alias lu='lwrun --update'
alias search='nix search nixpkgs'

# Очистка терминала
alias c='clear'

# Обновление системы

alias flup='nix flake update ~/.nix'
alias up='sudo nixos-rebuild switch --upgrade --flake ~/.nix'
alias rb='sudo nixos-rebuild switch --flake ~/.nix'

#Для VPN torctl (ставится из репозитория blackarch)

alias tstart='sudo torctl start'
alias tstop='sudo torctl stop'
alias trestart='sudo torctl restart'

#Файловый менеджер MC
alias mcr='sudo mc'

alias wget='wget -c -T 5'

#Выключение и перезагрузка
alias r='reboot'
alias s='shutdown -h now'

#Доступ по shh

alias sshon='systemctl start sshd'
alias sshoff='systemctl stop sshd'

alias kws='sh "~/MEGA/INSTALL/KillWineServer.sh"'

#Запись консоли
alias arec='asciinema rec'
