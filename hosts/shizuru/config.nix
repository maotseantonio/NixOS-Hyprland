# Main default config
{
  config,
  pkgs,
  host,
  username,
  options,
  lib,
  inputs,
  outputs,
  system,
  ...
}:
let

  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
    ]
  );

in
{
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/system

  ];

  nixpkgs.overlays = [
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
      pkgs-master = import inputs.nixpkgs-master {
         system = final.system;
         config.allowUnfree = true;
      };

    })
  ];
  #drivers.amdgpu.enable = false;
  drivers.intel.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;
  system.kernel.enable = true;
  system.bootloader-systemd.enable = false;
  system.bootloader-grub.enable = true;
  system.plymouth.enable = true;
  system.audio.enable = true;
  system.displayManager.enable = true;
  system.powermanagement.enable = true;
  system.scheduler.enable = true;
  #system.btrfs.enable = false;
  system.zfs.enable = true;
  system.zram.enable = true;
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  catppuccin.tty.enable = true;
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  users = {
    mutableUsers = true;
  };

  environment.systemPackages =
    (with pkgs; [

      libva-utils
      libvdpau-va-gl
      intel-compute-runtime
      intel-vaapi-driver
      vaapiVdpau
      mesa
      egl-wayland
      pkgs-master.waybar # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];
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
    TERMINAL = "wezterm";
    VISUAL = "vscodium";
    GSK_RENDERER = "gl";
    NIXPKGS_ALLOW_UNFREE = "1";
  };
  system.stateVersion = "25.05"; # Did you read the comment?
}
