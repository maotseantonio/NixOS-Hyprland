{ config, pkgs, host, username, options, lib, inputs, system, ...}: 
{
  imports = [ ./hardware-configuration.nix ];

  # Make unfree software explicit
  nixpkgs.config.allowUnfree = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];

  time.timeZone = "Asia/Yangon";

  networking.hostId = "e6ff0de6";
  networking.hostName = "shizuru";
  services.zfs.autoSnapshot.enable = true;
  services.zfs.autoScrub.enable = true;

  networking.networkmanager.enable = true;
#  networking.nameservers = [ "1.0.0.1" "1.1.1.1" ];
environment.systemPackages = with pkgs; [ 
   git
   vim
   wget
   curl
   pciutils

];
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      emojione
      noto-fonts
    #  noto-fonts-cjk
    #  noto-fonts-extra
    #  inconsolata
    #  material-icons
    #  liberation_ttf
      dejavu_fonts
   #   terminus_font
   #   siji
      unifont
    ];
    fontconfig.defaultFonts = {
      monospace = [
        "DejaVu Sans Mono"
      ];
      sansSerif = [
        "DejaVu Sans"
        "Noto Sans"
      ];
      serif = [
        "DejaVu Serif"
        "Noto Serif"
      ];
    };
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # GNOME 40
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.printing.enable = true;

  sound.enable = true;
  services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        wireplumber.enable = true;
      };
    };


  nix = {
    trustedUsers = [ "root" "antonio" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services.xserver.libinput.enable = true;

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ bashInteractive zsh ];

  users = {
    users.siraben = {
      shell = pkgs.zsh;
      useDefaultShell = false;
      isNormalUser = true;
      home = "/home/siraben";
      description = "Ben Siraphob";
      extraGroups = [ "wheel" "networkmanager" "dialout" ];
    };
  };

  system.stateVersion = "21.11";

}

