{
  description = "MaotseNyein NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";     
    nix = {
      url = "github:NixOS/nix/2.26-maintenance";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-alien.url = "github:thiagokokada/nix-alien"; 
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    catppuccin.url = "github:catppuccin/nix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };
    matugen = {
      url = "github:/InioX/Matugen";
    };
    yazi.url = "github:sxyazi/yazi";
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprsunset = {
      url = "github:hyprwm/hyprsunset";
    };
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
    hyprscroller = {
        url = "github:maotseantonio/hyprscroller-flake";
        inputs.hyprland.follows = "hyprland";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
    };
    textfox.url = "github:maotseantonio/textfox";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    stylix.url = "github:danth/stylix"; 
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nyxexprs.url = "github:notashelf/nyxexprs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvchad4nix = {
      url = "github:MOIS3Y/nvchad4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad-on-steroids = {
      # <- here
      url = "github:maotseantonio/nvchad_config";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
        url = "github:Gerg-L/spicetify-nix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    nh.url = "github:viperML/nh";
    nur.url = "github:nix-community/NUR";
    lix-module = {
        url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    hy3,
    chaotic,
    lix-module,
    ...
  }: let
    system = "x86_64-linux";
    host = "shizuru";
    username = "antonio";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit host;
          inherit chaotic;
        };
        modules = [
          ./hosts/${host}/config.nix
          inputs.spicetify-nix.nixosModules.default
          inputs.chaotic.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.catppuccin.nixosModules.catppuccin
          lix-module.nixosModules.default
          {
            nixpkgs.overlays = [
              inputs.hyprpanel.overlay
              (final: prev: {
                nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
              })
            ];
          }
        ];
      };
    };
  };
}
