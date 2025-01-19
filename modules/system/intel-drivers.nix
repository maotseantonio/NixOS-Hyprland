{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.drivers.intel;
in {
  options.drivers.intel = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };

    # OpenGL
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libva
        vaapiVdpau
        intel-compute-runtime
        libva-utils
        libvdpau-va-gl
      ];
    };
  };
}
