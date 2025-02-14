{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    nitch
    #rustup
    github-cli
    neovide
    wezterm
    hyprpicker 
    #protonvpn-gui
    #hiddify-app
    #inputs.zen-browser.packages."${pkgs.system}".default
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages.${pkgs.system}.agsFull
    inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
    #inputs.yazi.packages.${pkgs.system}.default
    microfetch
    yazi
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
