{
  inputs,
  pkgs,
  ...
}:
let
    hyprFlake = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalFlake = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
in
{
  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland;
      portalPackage = portalFlake; 
      xwayland.enable = true;
    };
    appimage = {
        enable = true;
        binfmt = true;
    };
    nix-ld.enable = true;
    waybar.enable = false;
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

    virt-manager.enable = false;

    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};

    xwayland.enable = true;
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
