{ config, pkgs, inputs, ... }:
let
  ax-shell = pkgs.fetchFromGitHub {
        owner = "maotseantonio";
        repo = "Ax-Shell";
        rev = "2af353feb50edcb1fddf3477a51d861e5b1c1fa5";
        hash = "sha256-2qyXOBTsm7oo1FJgCu5+E2X+wyr/kpVB+SlvhvzwOIM=";    
    };
   fabric-bar = pkgs.writeScriptBin "fabric-bar" (builtins.readFile ./fabric.sh);

in
{
  home.file."${config.xdg.configHome}/Ax-Shell" = {
    source = ax-shell;
  };

  home.file.".local/share/fonts/tabler-icons.ttf" = {
    source = "${ax-shell}/assets/fonts/tabler-icons/tabler-icons.ttf";
  };

  home.file."${config.xdg.configHome}/matugen/config.toml" = {
    source = ./matugen.toml;
  };
   
  home.packages = with pkgs; [
    matugen
    cava
    fabric-bar
    #hyprsunset
    wlinhibit
    tesseract
    imagemagick
    nur.repos.HeyImKyu.fabric-cli
    (nur.repos.HeyImKyu.run-widget.override {
      extraPythonPackages = with python3Packages; [
        ijson
        pillow
        psutil
        requests
        setproctitle
        toml
        watchdog
        thefuzz
        numpy
        chardet
      ];
      extraBuildInputs = [
        nur.repos.HeyImKyu.fabric-gray
        networkmanager
        networkmanager.dev
        playerctl
      ];
    })
  ];
  

  wayland.windowManager.hyprland.settings.layerrule = [
    "noanim, fabric"
  ];
}
