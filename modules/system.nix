{
  pkgs,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}:
{
  # imports = [ inputs.nix-gaming.nixosModules.default ];
   system.autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
            "--update-input"
            "nixpkgs"
            "-L"
        ];
        #dates = "02:00";
        randomizedDelaySec = "45min";
    };
    
   nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    baobab
    btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
    ffmpeg   
    glib #for gsettings to work
    gsettings-qt
    git
    killall  
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    xdg-user-dirs
    xdg-utils

    fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];})
  ];

  time.timeZone = "Asia/Yangon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/mocha.yaml";
  stylix.targets.spicetify.enable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.fish.enable = true;
}
