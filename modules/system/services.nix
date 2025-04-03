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
}: {
  
  services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      desktopManager.xterm.enable = false;
      desktopManager.runXdgAutostartIfNone = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    smartd = {
      enable = false;
      autodetect = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;
    udev.enable = true; 
    envfs.enable = true;
    dbus.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };

    libinput.enable = true;
    rpcbind.enable = false;
    nfs.server.enable = false;
    openssh.enable = true;
    blueman.enable = true;
    #v2ray.package = pkgs.pkgs-master.v2ray;
    #v2ray.enable = true;
    #v2raya.package = pkgs.pkgs-master.v2raya;
    #v2raya.enable = true;
    #printing = {
    #  enable = false;
    #  drivers = [
    # pkgs.hplipWithPlugin
    #  ];
    #};

    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};

    #ipp-usb.enable = true;

    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};
  };
}
