{
  description = "MaotseNyein NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nix = {
       url = "github:NixOS/nix/2.28.1";
       inputs.nixpkgs.follows = "nixpkgs";
     };
    # lix = {
    #   url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #   };
    # };
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    anyrun.url = "github:fufexan/anyrun/launch-prefix"; 
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    walker.url = "github:abenz1267/walker";
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
    nvf.url = "github:notashelf/nvf";
    yazi.url = "github:sxyazi/yazi";
    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };
    niri = {
     url = "github:sodiboo/niri-flake";
     inputs.nixpkgs.follows = "nixpkgs";
    };
    astal-bar = {
        url = "github:linuxmobile/astal-bar";
        inputs.nixpkgs.follows = "nixpkgs";
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
    custom-nixpkgs = {
      url = "github:maotseantonio/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox.url = "github:adriankarlen/textfox";
    #hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    #fabric.url = "github:Fabric-Development/fabric";
    hyprscroller = {
        url = "github:maotseantonio/hyprscroller-flake";
        inputs.hyprland.follows = "hyprland";
    };
    hyprddm.url = "github:maotseantonio/hyprddm";
    stylix = {
        url =  "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "home-manager";
     };
    zen-browser = {
        url = "github:youwen5/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
     
     };
     ax-shell.url = "github:maotseantonio/AX-Shell";
    nyxexprs.url = "github:notashelf/nyxexprs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvchad4nix = {
      url = "github:MOIS3Y/nvchad4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvchad-on-steroids = {
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
    nur = {
        url = "github:nix-community/NUR";
        inputs.nixpkgs.follows = "nixpkgs";
     };
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-master,
    nixpkgs-stable,
    home-manager,
    chaotic,
    nur,
    zjstatus,
    nvf,
    nixvim,
    #lix-module,
    custom-nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    host = "shizuru";
    username = "antonio";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-master = import nixpkgs-master {
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
          inherit pkgs-master;
        };
        modules = [
          ./hosts/${host}/config.nix
          inputs.spicetify-nix.nixosModules.default
          inputs.chaotic.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.nixos-hardware.nixosModules.huawei-machc-wa
          inputs.nvf.nixosModules.default
          #lix-module.nixosModules.default
          {
            nixpkgs.overlays = [
              inputs.hyprpanel.overlay
              inputs.niri.overlays.niri
              nur.overlays.default
              custom-nixpkgs.overlays.default
              (final: prev: {
                 stable = import nixpkgs-stable {
                 config.allowUnfree = true;
                 config.nvidia.acceptLicense = true;
                 };
                nvchad = inputs.nvchad4nix.packages."${pkgs.system}".nvchad;
                zjstatus = inputs.zjstatus.packages."${pkgs.system}".default;
              })
            ];
          }
        ];
      };
    };
  };
}
