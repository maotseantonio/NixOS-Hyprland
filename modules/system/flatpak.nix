{
  inputs,
  pkgs,
  lib,
  system,
  ...
}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
  services = {
    flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"
        #"com.calibre_ebook.calibre"
        #"org.getoutline.OutlineClient"
      ];
    };
  };  
}
