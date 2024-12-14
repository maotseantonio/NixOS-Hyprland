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
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

}
