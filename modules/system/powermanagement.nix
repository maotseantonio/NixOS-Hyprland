{
  pkgs,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.system.powermanagement;
in {
  options.system.powermanagement = {
    enable = mkEnableOption "Enable Powermanagement for Laptop";
  };

  config = mkIf cfg.enable {
    services = {
      power-profiles-daemon.enable = true;
      fwupd.enable = true;
      #upower.enable = true;
      gnome.gnome-keyring.enable = true;
      thermald.enable = true;
      tlp.enable = false;
      tlp.settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 1;

        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 1;

        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "performance";

        INTEL_GPU_MIN_FREQ_ON_AC = 500;
        INTEL_GPU_MIN_FREQ_ON_BAT = 500;
      };
    };
  };
}
