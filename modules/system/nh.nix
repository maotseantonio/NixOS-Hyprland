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
  programs.nh = {
    enable = true;
    flake = "/home/antonio/NixOS-Hyprland";
    clean = {
      enable = true;
      extraArgs = "--keep-since 3d --keep 3";
    };
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}
