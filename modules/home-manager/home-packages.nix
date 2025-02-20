{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    #rustup
    github-cli
    neovide
    wezterm
    hyprpicker  
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages.${pkgs.system}.agsFull
    inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
    microfetch
    inputs.yazi.packages.${pkgs.system}.yazi
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
