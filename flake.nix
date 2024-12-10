{
  description = "MaotseNyein NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-alien.url = "github:thiagokokada/nix-alien";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    catppuccin.url = "github:catppuccin/nix";
    matugen = {
        url = "github:/InioX/Matugen";
    };

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

    hyprpanel = {
         url = "github:Jas-SinghFSU/HyprPanel";
         inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
        url = "github:kaylorben/nixcord";
    };
    textfox.url = "github:adriankarlen/textfox";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # hyprland development
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
    stylix.url = "github:danth/stylix";
    wezterm.url = "github:wez/wezterm?dir=nix";
    nixos-boot.url = "github:Melkor333/nixos-boot";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
    nyxexprs.url = "github:notashelf/nyxexprs";


    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
        url = "github:Gerg-L/spicetify-nix";
        inputs.nixpkgs.follows = "nixpkgs";
   };

    nvix = {
            url = "github:niksingh710/nvix";
            inputs.nixpkgs.follows = "nixpkgs";
    };

    dedsec-grub-theme = {
            url = "gitlab:VandalByte/dedsec-grub-theme";
            inputs.nixpkgs.follows = "nixpkgs";
    };
    sddm-sugar-candy-nix = {
            url = "github:maotseantonio/sddm-sugar-candy-nix";
            inputs.nixpkgs.follows = "nixpkgs";
  };
};
  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , ...
    }:
    let
      system = "x86_64-linux";
      host = "shizuru";
      username = "antonio";
      #defaultPackage.x86_64-linux = wezterm.packages.x86_64-linux.default;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            ./hosts/${host}/config.nix
            inputs.dedsec-grub-theme.nixosModule
            inputs.nixos-boot.nixosModules.default
            inputs.spicetify-nix.nixosModules.default
            inputs.chaotic.nixosModules.default
            inputs.sddm-sugar-candy-nix.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            #inputs.zen-browser.packages."${system}".default
            inputs.stylix.nixosModules.stylix
            { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }
          ];
        };
      };

    };
}
