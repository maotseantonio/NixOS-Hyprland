{ pkgs, config, host, username, options, lib, inputs, system, ... }:

{
  programs.nh = {
    enable = true;
    flake = "/home/antonio/NixOS-Hyprland";
    clean = {
      enable = true;
      extraArgs = "--keep-since 1w";
    };
  };
}