{
  config,
  lib,
  pkgs,
  system,
  inputs,
  options,
  ...
}: {
  
  home.packages = with pkgs; [
    #rustup
    #github-cli
    neovide 
    inputs.wezterm.packages.${pkgs.system}.default
    #wezterm
    hyprpicker  
    hyprpanel
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.astal-bar.packages.${pkgs.system}.default
    inputs.ags.packages.${pkgs.system}.agsFull
    inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
    inputs.zen-browser.packages."${pkgs.system}".default 
    pkgs-master.microfetch
    inputs.yazi.packages.${pkgs.system}.yazi
    #yazi
    gpu-screen-recorder
    libqalculate
    dbus-glib
    gtkmm4
    komikku
    mangal
    mangareader
    tmux
    gtk4
  ];
}
