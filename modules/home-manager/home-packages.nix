{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    protonvpn-gui
    manga-tui
    nitch
    # rustup
    github-cli
    neovide
    wezterm
    hyprpicker
    #inputs.wezterm.packages.${pkgs.system}.default
    # inputs.zen-browser.packages."${pkgs.system}".default
 #   inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages.${pkgs.system}.agsFull
   # inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
    yazi
    # inputs.yazi.packages.${pkgs.system}.default
    microfetch
    gpu-screen-recorder
  #  vscodium
    libqalculate
   # libdbusmenu-gtk3
   # dbus-glib
  #  gtkmm3
 #   gtkmm4
 #   gtkmm2
 #   komikku
#    mangal
#    mangareader
#    lutgen
#    tmux
#    gtk4
  ];
}
