{ config, pkgs, ... }:

{
  home.enableNixpkgsReleaseCheck = false;
  home.username = "username";
  home.homeDirectory = "/home/username";
  home.stateVersion = "25.11";
  
  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  programs.git = {
    enable = true;
    settings = {
    #  user.name = "Login";
    #  user.email = "email";
    #  init.defaultBranch = "main";
    };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch --flake /home/username/.nix";
      up = "sudo nixos-rebuild switch --upgrade --flake /home/username/.nix";
    };
     profileExtra = ''
     if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
       export XDG_CURRENT_DESKTOP=Hyprland
       export XDG_SESSION_DESKTOP=Hyprland
       export XDG_SESSION_TYPE=wayland
       exec start-hyprland
     fi
     ''; 
  };
}
