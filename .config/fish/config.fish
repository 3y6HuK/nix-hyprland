#source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

set fish_greeting ""
# Aliases
if [ -f $HOME/.config/fish/system.fish ]
       source $HOME/.config/fish/system.fish
end
