# Main default config
{ config, pkgs, host, username, options, lib, inputs, system, ...}: let
  
  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );
  
  in {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/amd-drivers.nix
    ../../modules/bootloader.nix
    ../../modules/system.nix
    ../../modules/wayland.nix
    ../../modules/services.nix
    ../../modules/hardwareconf.nix
#    ../../modules/pkgs.nix
    #./variables.nix
    
  ];
  
  

    
  nixpkgs.overlays = [
    (final: prev: {
      matugen = final.rustPlatform.buildRustPackage rec {
        pname = "matugen";
        version = "2.4.0";

        src = final.fetchFromGitHub {
          owner = "InioX";
          repo = "matugen";
          rev = "refs/tags/v${version}";
          hash = "sha256-l623fIVhVCU/ylbBmohAtQNbK0YrWlEny0sC/vBJ+dU=";
        };

        cargoHash = "sha256-FwQhhwlldDskDzmIOxhwRuUv8NxXCxd3ZmOwqcuWz64=";

        meta = {
          description = "Material you color generation tool";
          homepage = "https://github.com/InioX/matugen";
          changelog = "https://github.com/InioX/matugen/blob/${src.rev}/CHANGELOG.md";
          license = final.lib.licenses.gpl2Only;
          maintainers = with final.lib.maintainers; [ lampros ];
          mainProgram = "matugen";
        };
      };
    })
    (final: prev: {
        sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
        pname = "sf-mono-liga-bin";
        version = "dev";
        src = inputs.sf-mono-liga-src;
        dontConfigure = true;
        installPhase = ''
            mkdir -p $out/share/fonts/opentype
            cp -R $src/*.otf $out/share/fonts/opentype/
            '';
        };
     }) 
    ];  

 

  # BOOT related stuff
 


  drivers.amdgpu.enable = false;
  drivers.intel.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;

  # networking
  networking.networkmanager.enable = true;
  networking.hostName = "${host}";
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Set your time zone.

    #chaotic.scx.enable = true; # by default uses scx_rustland scheduler
    #chaotic.scx.scheduler = "scx_rusty";
    #chaotic.mesa-git.enable = true;
   nixpkgs.config.allowUnfree = true;
  
  users = {
    mutableUsers = true;
  };

  environment.systemPackages = (with pkgs; [
       
    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
	  python-packages
  ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    material-icons
    sf-mono-liga-bin
    #iosevka-bin
    font-awesome
    terminus_font
    nerd-fonts.monaspace
    nerd-fonts.jetbrains-mono 
        #nerd-fonts.jetBrains-mono
        #(nerd-fonts.override {fonts = ["JetBrainsMono" ];})
 	];

  # Extra Portal Configuration
 
  # Cachix, Optimization settings and garbage collection automation
   # Virtualization / Containers
  virtualisation.libvirtd.enable = false;
  virtualisation.podman = {
    enable = false;
    dockerCompat = false;
    defaultNetwork.settings.dns_enabled = false;
  };

  # OpenGL
  hardware.graphics = {
    enable = true;
  };

  console.keyMap = "${keyboardLayout}";

  # For Electron apps to use wayland
    environment.variables = {
        VDAPU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
    };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables = {
  EDITOR = "nvim";
  BROWSER = "firefox";
  TERMINAL = "kitty";
  VISUAL = "vscodium";
  GSK_RENDERER = "gl";
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
