{ config, pkgs, ... }:

{
  home.enableNixpkgsReleaseCheck = false;
  home.username = "freedomsky";
  home.homeDirectory = "/home/freedomsky";
  home.stateVersion = "25.11";
  programs.git = {
  enable = true;
  #settings = {
  #  user.name = "name";
  #  user.email = "email";
  #  init.defaultBranch = "main";
  #  };
  };
  programs.bash = {
    enable = true;
    shellAliases = {
      rb = "sudo nixos-rebuild switch";
      up = "sudo nix-channel --update && sudo nixos-rebuild switch";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
