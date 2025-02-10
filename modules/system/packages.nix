{
  pkgs,
  config,
  inputs,
  lib,
  chaotic,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (ags.overrideAttrs (oldAttrs: {
      inherit (oldAttrs) pname;
      version = "1.8.2";
    }))
    brightnessctl # for brightness control
    libinput
    libinput-gestures 
    cliphist
    eog
    gnome-system-monitor
    file-roller
    grim
  #  pwvucontrol_git
    gtk-engine-murrine #for gtk themes
    hyprcursor # requires unstable channel
    hypridle # requires unstable channel
    imagemagick
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum #kvantum
    networkmanagerapplet
    nwg-look # requires unstable channel
    nwg-dock-hyprland
    # nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    libsForQt5.qt5ct
    # kdePackages.full
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    yad
    yt-dlp
    nix-ld
    power-profiles-daemon
    fd
    home-manager
    bluez-tools
#    wgpu-utils
    gtk3
    gtk4
    fish
    atuin
    bun
    dart-sass
    nodejs
    sassc
    libgtop
    starship
    telegram-desktop
    vesktop
    papirus-folders
    papirus-icon-theme
    spotify
    zoxide
   # bibata-cursors
     vivid
  ];
}
