{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nvchad4nix.homeManagerModule
    inputs.nixcord.homeManagerModules.nixcord
    inputs.hyprland.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.textfox.homeManagerModules.default
    
  ];
  nixpkgs.config.allowUnfree = true; 
  programs.cava = {
      enable = true;
  };
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
  programs.zathura = {
    enable = true;
  };
  programs.imv = {
    enable = true;
  };
  programs.htop = {
      enable = true;
  };
  catppuccin.enable = true;
 
  home.packages = [
    # (pkgs.nerd-fonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.protonvpn-gui
    pkgs.manga-tui
    pkgs.hyprpanel
    pkgs.nitch
    pkgs.rustup
    pkgs.hiddify-app
    pkgs.neofetch
    pkgs.github-cli
    pkgs.neovide
    inputs.wezterm.packages.${pkgs.system}.default
    inputs.zen-browser.packages."${pkgs.system}".default
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages.${pkgs.system}.agsFull
    inputs.astal.packages.${pkgs.system}.tray
    inputs.astal.packages.${pkgs.system}.hyprland
    inputs.astal.packages.${pkgs.system}.io
    inputs.astal.packages.${pkgs.system}.apps
    inputs.astal.packages.${pkgs.system}.battery
    inputs.astal.packages.${pkgs.system}.bluetooth
    inputs.astal.packages.${pkgs.system}.mpris
    inputs.astal.packages.${pkgs.system}.network
    inputs.astal.packages.${pkgs.system}.notifd
    inputs.astal.packages.${pkgs.system}.powerprofiles
    inputs.astal.packages.${pkgs.system}.wireplumber
    pkgs.firedragon
    pkgs.yazi
    pkgs.microfetch
    #inputs.yazi.packages.${pkgs.system}.default
    pkgs.gpu-screen-recorder
    pkgs.vscodium
    pkgs.libqalculate
    pkgs.libdbusmenu-gtk3
    pkgs.dbus-glib
    pkgs.gtkmm3
    pkgs.gtkmm4
    pkgs.gtkmm2
    pkgs.komikku
    pkgs.mangal
    pkgs.mangareader
    pkgs.lutgen
    pkgs.tmux
    pkgs.tmux-sessionizer
    pkgs.tmuxPlugins.sidebar
    
  ];

  home.file = {
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  
  home.sessionVariables = {
     EDITOR="nvim";
     TERMINAL="wezterm";
     VISUAL="codium";
     BROWSER="firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
