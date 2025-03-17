{
  config,
  pkgs,
  pkgs-master,
  inputs,
  options,
  lib,
  system,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
  ]; 
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.bottom = {
    enable = true;
  };
  programs.zellij = {
    enable = true;
  };
  programs.gh = {
    enable = true;
    package = pkgs.gh;
  };
  programs.lsd = {
    enable = true;
  };
  programs.btop = {
    enable = true;
  };
  programs.bat = {
    enable = true;
  };
  programs.imv = {
    enable = true;
  };
  programs.htop = {
    enable = true;
  };
  catppuccin.enable = true;

  home.file = {
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "wezterm";
    VISUAL = "codium";
    BROWSER = "firefox";
  };
  #home.backupFileExtension = "bkp";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
