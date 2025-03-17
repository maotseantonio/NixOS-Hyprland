{ pkgs, inputs, username, host, system, lib, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "bkp";
      extraSpecialArgs = {
          inherit inputs username host;
      };
       users.${username} = {
      imports =
        if (host == "shizuru") then
          [ ../../modules/home-manager ]
        else
          [ ../../modules/home-manager/default.nix ];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };

  };
   
  users = { 
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video" 
        "input" 
        "audio"
      ];

    # define user packages here
    packages = with pkgs; [
      ];
    };
    
    defaultUserShell = pkgs.fish;
  }; 
  nix.settings.allowed-users = ["${username}"];
  environment.shells = with pkgs; [ fish ];
  environment.systemPackages = with pkgs; [ fzf ]; 
  programs.fish.enable = true;
  programs.fish.interactiveShellInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
  '';
   programs = {

  # Zsh configuration
	  zsh = {
    	enable = false;
	  	enableCompletion = false;
      ohMyZsh = {
        enable = false;
        plugins = ["git"];
        theme = "xiong-chiamiov-plus"; 
      	};
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      promptInit = ''
        fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
        
        #pokemon colorscripts like. Make sure to install krabby package
        #krabby random --no-mega --no-gmax --no-regional --no-title -s; 
        
        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
        '';
      };
   };
}
