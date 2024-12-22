{ pkgs, config, inputs, lib, ...}:

{
  environment.systemPackages = with pkgs; [
    brightnessctl # for brightness control
    cliphist
    eog
    gnome-system-monitor
    file-roller
    grim
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
    nvtopPackages.full
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
    power-profiles-daemon
    fd
    home-manager
    bluez-tools
    wgpu-utils   
    yazi
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
    sddm 
    catppuccin-sddm-corners
    zoxide
    bibata-cursors
     
  ];
}
