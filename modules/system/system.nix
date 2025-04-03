{
  pkgs,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    baobab
    #btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
    ffmpeg
    glib #for gsettings to work
    gsettings-qt
    git
    killall
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    xdg-user-dirs
    xdg-utils
    hyprpicker
    fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];})
  ]; 
  system.stateVersion = "25.05";
}
