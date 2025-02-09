{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
        #protonvpn-gui
        #manga-tui
    nitch
        #    rustup
    github-cli
    neovide
        #inputs.wezterm.packages.${pkgs.system}.default
    #inputs.zen-browser.packages."${pkgs.system}".default
    #inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages.${pkgs.system}.agsFull
    yazi
    wezterm
    microfetch
    gpu-screen-recorder
    vscodium
    libqalculate
        #libdbusmenu-gtk3
        #dbus-glib
        #mangal
        #mangareader
        #lutgen
    tmux
        #tmux-sessionizer
        #tmuxPlugins.sidebar
        #gtk4
        #mangayomi
  ];
}
