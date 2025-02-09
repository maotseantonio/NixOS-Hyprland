{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (ags.overrideAttrs (oldAttrs: {
      inherit (oldAttrs) pname;
      version = "1.8.2";
    }))
    brightnessctl # for brightness control 
    cliphist
    eog
    gnome-system-monitor
    file-roller
    grim
    pwvucontrol_git
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
    #nwg-dock-hyprland
    #nvtopPackages.full
    pamixer
    pavucontrol
    playerctl
    polkit_gnome
    pyprland
    libsForQt5.qt5ct
    qt6ct
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
    #swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    yad
    yt-dlp
    nix-ld
    fd
    home-manager
    bluez-tools
        #gtk3
        #gtk4
    #gtkmm4
    #gtkmm3
    fish
    atuin
    dart-sass
    nodejs
    sassc
    libgtop
    starship
        #telegram-desktop
        #vesktop
        #papirus-folders
        #papirus-icon-theme
    zoxide
        #bibata-cursors
        #spotify
  ];
}
