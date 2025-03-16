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
  boot.supportedFilesystems = [ "zfs" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.zfs.devNodes = "{$DISK_PATH}";
  #boot.zfs.devNodes = "/dev/disk/by-partuuid";
  networking.hostName = "shizuru"; # Define your hostname.
  networking.hostId = "$(head -c 8 /etc/machine-id)";  
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  
  # Set your time zone.
   time.timeZone = "Asia/Yangon";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
   networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   services.xserver.enable = true;
   services.xserver.xkb.layout = "us";
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.antonio = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  # programs.firefox.enable = true;

   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     curl
     pciutils
   ];
    
    zramSwap = {
        enable = true;
        priority = 100;
        memoryPercent = 200;
        swapDevices = 1;
        algorithm = "zstd";
    };
    programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
   services.openssh.enable = true;
   nix = {
    package = pkgs.lix;
    settings = {
      allowed-users = ["root" "@wheel" "antonio"];
      trusted-users = ["root" "@wheel" "antonio" "@builders"];
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
   # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  #system.copySystemConfiguration = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}
