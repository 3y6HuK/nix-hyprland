# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.supportedFilesystems = [ "ntfs" ];

  #boot.loader = {
  #  efi.canTouchEfiVariables = true;
  #  grub = {
  #    enable = true;
  #    devices = [ "nodev" ];
  #    efiSupport = true;
  #    useOSProber = true;
  #    theme = "/home/username/.themes/nixos";
  #    gfxmodeEfi = "1920x1080";
  #    backgroundColor = "#1B3E7E";
  #    extraConfig = ''
  #     set timeout=1
  #     '';
  #  };
  #};

 fileSystems."/" =
    { options = [
	      "noatime"
	      "space_cache=v2"
        "compress=zstd:3"
	      "ssd"
	      "discard=async"
      ];

    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4b584ac1-1078-474d-a999-b1b9de42d9a4";
      fsType = "btrfs";
      options = [ "noatime" "discard=async" "ssd" "compress=zstd:3" "space_cache=v2" ];
    };


  #time.hardwareClockInLocalTime = true;

  # Use latest kernel.
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_zen;
  #boot.kernelPackages = pkgs.linuxPackages_lqx;
   boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  #Network 
 networking.networkmanager.enable = true; 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking = {
      hostName = "nixos";
      nameservers = [ "127.0.0.1" "::1" ];
      networkmanager.dns = "none";
    };
  #Dnscrypt-proxy
  services.dnscrypt-proxy = {
      enable = true;
      settings = {
        server_names = ["scaleway-fr" "google" "yandex" "cloudflare"];
	listen_addresses = ["127.0.0.1:53" "[::1]:53"];
      };
    };

  # Set your time zone.
  time.timeZone = "Asia/Vladivostok";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";
  i18n.extraLocaleSettings = {
   LC_ADDRESS = "ru_RU.UTF-8";
   LC_IDENTIFICATION = "ru_RU.UTF-8";
   LC_MEASUREMENT = "ru_RU.UTF-8";
   LC_MONETARY = "ru_RU.UTF-8";
   LC_NAME = "ru_RU.UTF-8";
   LC_NUIMERIC = "ru_RU.UTF-8";
   LC_PAPER = "ru_RU.UTF-8";
   LC_TELEPHONE = "ru_RU.UTF-8";
   LC_TIME = "ru_RU.UTF-8";
  }; 
   console = {
    font = "cyr-sun16";
    keyMap = "ru";
  };
  #  useXkbConfig = true; # use xkb.options in tty.

  #Video Intel
  #services.xserver.videoDrivers = [ "intel" ];
  #services.xserver.extraOptions = [ "Option \"TearFree\" \"true\"" ];
  #services.xserver.deviceSection = ''
  #  Option "DRI" "2"
  #  Option "TearFree" "true"
  #'';

  boot.kernelModules = [ "kvm-intel" "i915" "i915_gvt" ];  # базовые модули Intel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # для 32‑битных приложений
    extraPackages = with pkgs; [
      intel-media-driver  # аппаратное ускорение видео
      intel-vaapi-driver # VA‑API для Intel
      mesa # открытые драйверы OpenGL/Vulkan
    ];
  };

  #Video AMD
  #services.xserver.videoDrivers = ["amdgpu"];
  #boot.initrd.kernelModules = ["amdgpu"];
  #hardware.opengl.extraPackages = with pkgs; [ amdvlk ];
  # Для 32-битных приложений
  #hardware.opengl.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];
  
  #Video Nvidia
    # Включение OpenGL
  #hardware.opengl = {
  #  enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
  #};

  # Загрузка драйвера NVIDIA для Xorg и Wayland
  #services.xserver.videoDrivers = ["nvidia"];

  # Включение modesetting (требуется для корректной работы с некоторыми Wayland-композиторами и DE)
  #hardware.nvidia.modesetting.enable = true;

  # Опционально: включение управления питанием NVIDIA
  # hardware.nvidia.powerManagement.enable = true;

  # Опционально: включение NVIDIA Settings (доступен через nvidia-settings)
  #hardware.nvidia.nvidiaSettings = true;

  # Опционально: выбор конкретной версии драйвера
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  #   version = "555.58.02";
  #   sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
  #   sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
  #   openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
  #   settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
  #   persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
  # };
  
  #Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };
  # XDG Portal.
  services.dbus.enable = true;
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Переменные окружения для Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # подсказка приложениям использовать Wayland
    GBM_BACKEND = "drm";     # для корректной работы с GBM
    #GDK_SCALE = "2";  # HiDpi для GTK‑приложений
    #QT_SCALE_FACTOR = "2";  # HiDpi для Qt‑приложений
    XDG_CURRENT_DESKTOP = "Hyprland";
    DESKTOP_SESSION = "hyprland";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  #Автообновление
  system.autoUpgrade = {
    enable = true;
    flake = "/home/username/.nix";
    dates = "daily";
    flags = [ "--recreate-lock-file" ];
    allowReboot = false;
  };

  #Автоочистка
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  #Polkit
  security.polkit.enable = true;
    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
      };
    };
  };

  #Flatpak
  #services.flatpak.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with .
  #Autologin
  services.getty.autologinUser = "username";
  users.users.username = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "audio" "video" "networkmanager" "libvirtd" ]; # Enable for the user.
    packages = with pkgs; [];
  };

    #Gaming section
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "\${HOME}/.steam/root/compatibilitytools.d";
  };
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  #Services  
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.fstrim.enable = true;
  services.tumbler.enable = true; # Thumbnail support for images

  #Zram
   zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
    priority = 999;
  };

  #Шрифты 
  fonts.fontDir.enable = true;
  
  # List packages installed in system profile.
  programs.fish.enable = true; 
  programs.firefox.enable = true; # Firefox
  programs.thunar.enable = true; # Thunar
 
    #VSCode
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Другие расширения
      enkia.tokyo-night  # Пример тем
      ms-ceintl.vscode-language-pack-ru
    ];
  };

  #Virtmanager
  # Включение KVM/QEMU
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;
  services.spice-autorandr.enable = true;
  programs.virt-manager = {
    enable = true;
    package = pkgs.virt-manager;
  };
 
    nixpkgs.config.allowUnfree = true;
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-multi-rtmp
      obs-vaapi
      wlrobs
    ];
  })
    appimage-run
    appimageupdate
    ast-grep
    btop
    blueman
    bluez
    bluez-tools
    brightnessctl
    btrfs-progs
    cherrytree
    dconf
    devenv
    discord
    dnscrypt-proxy
    fd
    fastfetch
    file-roller
    firefox
    fishPlugins.fzf-fish
    fishPlugins.z
    fzf
    gparted
    gcc
    gedit
    glib
    git
    grim
    gsettings-desktop-schemas
    hyprcursor
    hypridle
    hyprland-autoname-workspaces
    hyprland-protocols
    hyprlang
    hyprlock
    hyprpaper
    hyprpicker
    hyprsunset
    hyprutils
    imagemagick
    jdk
    kitty
    lazygit
    libreoffice
    lm_sensors
    lua
    luajitPackages.luarocks-nix
    mako
    mangohud
    mc
    mermaid-cli
    maven
    mpv
    neovim
    nemo-fileroller
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu
    networkmanagerapplet
    nodejs
    nwg-look
    noto-fonts-emoji-blob-bin
    obsidian
    oh-my-fish
    openjdk
    pamixer
    pavucontrol
    p7zip
    p7zip-rar
    polkit_gnome
    protonup-ng
    python3
    qview
    qbittorrent
    ripgrep
    ripgrep-all
    slurp
    steam
    stylua
    swww
    swappy
    tectonic
    telegram-desktop
    thunar-archive-plugin
    thunar-volman
    thunderbird
    trash-cli
    unzip
    vlc
    vivaldi
    vivaldi-ffmpeg-codecs
    virtualenv
    vimPlugins.mason-nvim
    vimPlugins.mason-nvim-dap-nvim
    vimPlugins.mason-tool-installer-nvim
    vimPlugins.nvim-treesitter
    vimPlugins.LazyVim
    waybar
    wget
    wlogout
    wofi
    wttrbar
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    yt-dlp
  ];

    # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11"; # Did you read the comment?
  
}
