{ pkgs, config, host, username, options, lib, inputs, system, ... }:

{
   services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";
  services.displayManager.defaultSession = "hyprland";
  services.displayManager.sddm = {
      enable = true; # Enable SDDM.
      wayland.enable = true;
            #sugarCandyNix = {
            #enable = true;
            #settings = {
            #    Background = ./nixchan.png;
            #     ScreenWidth = 2160;
            #     ScreenHeight = 1440;
            #     FormPosition = "left";
            #     HaveFormBackground = true;
            #     PartialBlur = true;
            #     Font = "JetBrainsMono";
                #fontSize = "16";
            #     RoundCorners = 20;
            #};
        #};
      theme = "catppuccin-sddm-corners";
     settings = {
        Theme = {
            CursorTheme = "Bibata-Modern-Ice";    
        };
      };
    };

    services = {
    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
      desktopManager.xterm.enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    
    #greetd = {
    #  enable = true;
    #  settings = {
    #    default_session = {
    #      user = "greeter";
    #      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' - --user-menu --width '50' --container-padding '5' --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=darkgray;input=red' --cmd Hyprland"; # start Hyprland with a TUI login manager
    #    };
    #  };
    #};
    
    smartd = {
      enable = false;
      autodetect = true;
    };
    
	  gvfs.enable = true;
	  tumbler.enable = true;

	  pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
	    wireplumber.enable = true;
  	  };
	
	  udev.enable = true;
	  envfs.enable = true;
	  dbus.enable = true;

	  fstrim = {
      enable = true;
      interval = "weekly";
      };
  
    libinput.enable = true;

    rpcbind.enable = false;
    nfs.server.enable = false;
  
    openssh.enable = true;
    flatpak.enable = true;
	
  	blueman.enable = true;
  	power-profiles-daemon.enable = true;
    fwupd.enable = true;
    upower.enable = true;
    gnome.gnome-keyring.enable = true;
    #powerManagement.cpuFreqGovernor = "performance";
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
      # INTEL_GPU_MAX_FREQ_ON_AC=0;
      # INTEL_GPU_MAX_FREQ_ON_BAT=0;
      # INTEL_GPU_BOOST_FREQ_ON_AC=0;
      # INTEL_GPU_BOOST_FREQ_ON_BAT=0;

      # PCIE_ASPM_ON_AC = "default";
      # PCIE_ASPM_ON_BAT = "powersupersave";
    }; 
    #printing = {
    #  enable = false;
    #  drivers = [
        # pkgs.hplipWithPlugin
    #  ];
    #};
    
    #avahi = {
    #  enable = true;
    #  nssmdns4 = true;
    #  openFirewall = true;
    #};
    
    #ipp-usb.enable = true;
    
    #syncthing = {
    #  enable = false;
    #  user = "${username}";
    #  dataDir = "/home/${username}";
    #  configDir = "/home/${username}/.config/syncthing";
    #};

  };

}
