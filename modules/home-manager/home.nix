{ config, pkgs, inputs, ... }:

{
  imports = [
    ./scripts/scripts.nix
    ./nixy.nix
    ./nvchad.nix
    ./helix.nix
    ./nixcord.nix
    ./textfox.nix
    ./vscodium.nix
    ./spicetify.nix
    ./git.nix
    ./hyprland.nix
    ./gtk.nix
    ./fhsenv.nix
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
    inputs.ags.packages."${pkgs.system}".default
    inputs.astal.packages."${pkgs.system}".default
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    inputs.ags.packages."${pkgs.system}".hyprland
    inputs.ags.packages."${pkgs.system}".battery
    inputs.ags.packages."${pkgs.system}".network
    inputs.ags.packages."${pkgs.system}".bluetooth
    inputs.ags.packages."${pkgs.system}".tray
    inputs.ags.packages."${pkgs.system}".wireplumber
    inputs.ags.packages."${pkgs.system}".cava
    inputs.ags.packages."${pkgs.system}".greet 
    inputs.ags.packages."${pkgs.system}".mpris
    inputs.ags.packages."${pkgs.system}".notifd
    inputs.ags.packages."${pkgs.system}".powerprofiles
    inputs.ags.packages."${pkgs.system}".auth
    inputs.ags.packages."${pkgs.system}".river
    inputs.ags.packages."${pkgs.system}".apps
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
