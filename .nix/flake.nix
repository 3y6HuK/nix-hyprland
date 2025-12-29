{
  description = "Hyprland on Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    yandex-browser.url = "github:miuirussia/yandex-browser.nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zapret-discord-youtube, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.freedomsky = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      
        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
#            config = "general";
#            config = "general(ALT)";
#            config = "general(ALT2)";
            config = "general(ALT3)";
#            config = "general(ALT4)";
#            config = "general(ALT5)";
#            config = "general(ALT6)";
#            config = "general(ALT7)";
#            config = "general(ALT8)";
#            config = "general(ALT9)";
#            config = "general(ALT10)";
#            config = "general(ALT11)";
#            config = "general(ALT12)";
#            config ="general (SIMPLE FAKE)";
#            config ="general (SIMPLE FAKE ALT)";
#            config ="general (SIMPLE_FAKE_ALT2)";
#            config ="general (FAKE_TLS_AUTO)";
#            config ="general (FAKE_TLS_AUTO_ALT)";
#            config ="general (FAKE_TLS_AUTO_ALT2)";
#            config ="general (FAKE_TLS_AUTO_ALT3)";
           #config = "general (FAKE_TLS_AUTO_ALT3)";  # Или любой конфиг из папки configs (general, general(ALT), general (SIMPLE FAKE) и т.д.)
          };
        }

      ];
    };
  };
}

    # Пропиши в терминале, если только систему поставил:
    # nix profile install github:miuirussia/yandex-browser.nix#yandex-browser-stable  
    # nix flake lock --update-input yandex-browser  

