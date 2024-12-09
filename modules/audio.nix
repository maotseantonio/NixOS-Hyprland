{ pkgs, config, host, username, options, lib, inputs, system, ... }:
{
  services = {
      pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
	    wireplumber.enable = true;
  	  };
  };
}