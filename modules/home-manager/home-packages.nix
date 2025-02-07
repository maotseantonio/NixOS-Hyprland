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
    #inputs.zen-browser.packages."${pkgs.system}".default
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages.${pkgs.system}.agsFull
    inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
    yazi
    #inputs.Neve.packages.${pkgs.system}.default
    #inputs.yazi.packages.${pkgs.system}.default
    microfetch
    gpu-screen-recorder
    libqalculate
    dbus-glib
    gtkmm4
    komikku
    mangal
    mangareader
    tmux
    gtk4
    lunarvim
  ];
}
