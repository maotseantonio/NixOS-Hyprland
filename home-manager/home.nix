{ config, pkgs, inputs, ... }:

{
  imports = [
    #<catppuccin/modules/home-manager>
    ./scripts/scripts.nix
    ./nixy.nix
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nvchad4nix.homeManagerModule
    inputs.nixcord.homeManagerModules.nixcord
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config.allowUnfree = true; 
  home.username = "antonio";
  home.homeDirectory = "/home/antonio";
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
    emmet-language-server
    nixd ];
    extraConfig = inputs.nvchad-on-steroids; # <- here extraConfig from inputs
    hm-activation = true;
    backup = false;
  };
  programs.bat = {
    enable = true;
  };
  programs.zathura = {
    enable = true;
  };
  programs.nixcord = {
    enable = false;
      vesktop = {
      enable = false;
    };
    config = {
      themeLinks = [
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/midnight.theme.css"
      ];
      frameless = true;
      #      enabledThemes = "midnight.theme.css";
      plugins = {
        alwaysTrust.enable = true;
        alwaysAnimate.enable = true;
        #BetterAnimations.enable = true;
        anonymiseFileNames = {
          enable = true;
          anonymiseByDefault = true;
        };
        banger.enable = true;
        # betterFolders = {
        #   enable = true;
        #   showFolderIcon = "always";
        # };
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterNotesBox.enable = true;
        betterRoleDot.enable = true;
        betterUploadButton.enable = true;
        blurNSFW.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        crashHandler.enable = true;
        dearrow.enable = true;
        disableCallIdle.enable = true;
        emoteCloner.enable = true;
        experiments.enable = true;
        fakeNitro.enable = true;
        favoriteEmojiFirst.enable = true;
        favoriteGifSearch.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendInvites.enable = true;
        friendsSince.enable = true;
        fullSearchContext.enable = true;
        fixCodeblockGap.enable = true;
        gameActivityToggle.enable = true;
        gifPaste.enable = true;
        imageZoom.enable = true;
        loadingQuotes.enable = true;
        memberCount.enable = true;
        messageClickActions.enable = true;
        messageLogger = {
          enable = true;
	        deleteStyle = "text";
	       logDeletes = true;
	       logEdits = true;
	       ignoreSelf = true;
        };
        messageTags.enable = true;
        moreCommands.enable = true;
        moreKaomoji.enable = true;
        mutualGroupDMs.enable = true;
        newGuildSettings.enable = true;
        noBlockedMessages = {
          enable = true;
	        ignoreBlockedMessages = true;
        };
        noDevtoolsWarning.enable = true;
        noF1.enable = true;
        noReplyMention.enable = true;
        noProfileThemes.enable = true;
        noUnblockToJump.enable = true;
        openInApp.enable = true;
        permissionFreeWill.enable = true;
        pictureInPicture.enable = true;
        pinDMs.enable = true;
        plainFolderIcon.enable = true;
        platformIndicators.enable = true;
        previewMessage.enable = true;
        quickMention.enable = true;
        quickReply.enable = true;
        reactErrorDecoder.enable = true;
        relationshipNotifier.enable = true;
        replaceGoogleSearch = {
          enable = true;
        };
        secretRingToneEnabler.enable = true;
        sendTimestamps.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        silentTyping.enable = true;
        sortFriendRequests.enable = true;
        spotifyControls.enable = true;
        spotifyCrack.enable = true;
        spotifyShareCommands.enable = true;
        translate.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        unsuppressEmbeds.enable = true;
        userVoiceShow.enable = true;
        USRBG.enable = true;
        vencordToolbox.enable = true;
        viewIcons.enable = true;
        voiceChatDoubleClick.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        webKeybinds.enable = true;
        webRichPresence.enable = true;
        whoReacted.enable = true;
        youtubeAdblock.enable = true;
      };
    };
  };
  programs.spicetify =
   let
     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
   in
   {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblock
       hidePodcasts
       shuffle # shuffle+ (special characters are sanitized out of extension names)
     ];
     theme = spicePkgs.themes.catppuccin;
     colorScheme = "mocha";
   };
  programs.imv = {
    enable = true;
  };
  #programs.ghostty = {
  # enable = true;
  #};
  programs.git = {
    enable = true;
    userName = "maotseantonio";
    userEmail = "thetzinantonio@gmail.com";
  };
  catppuccin.enable = true;
  wayland.windowManager.hyprland.extraConfig = ''
      $configs = $HOME/.config/hypr/configs
      source=$configs/Settings.conf
      source=$configs/Keybinds.conf
      $UserConfigs = $HOME/.config/hypr/UserConfigs
      source= $UserConfigs/Startup_Apps.conf
      source= $UserConfigs/ENVariables.conf
      source= $UserConfigs/Monitors.conf
      source= $UserConfigs/Laptops.conf
      source= $UserConfigs/LaptopDisplay.conf
      source= $UserConfigs/WindowRules.conf
      source= $UserConfigs/UserDecorAnimations.conf
      source= $UserConfigs/UserKeybinds.conf
      source= $UserConfigs/UserSettings.conf
      source= $UserConfigs/WorkspaceRules.conf
      source= $HOME/.config/hypr/themes/mocha.conf
  '';

  wayland.windowManager.hyprland = {
      plugins = [
            inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.borders-plus-plus
#            /home/antonio/.nix-profile/lib/libborders-plus-plus.so
      ];
  };
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      packages = pkgs.papirus-icon-theme;
    };
    theme.packages = pkgs.catppuccin-gtk;
    theme.name = "catppuccin-Dark";
     gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

  };
 
  home.packages = [

     (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: 
        # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
        # lacking many basic packages needed by most software.
        # Therefore, we need to add them manually.
        #
        # pkgs.appimageTools provides basic packages required by most software.
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          # Feel free to add more packages here if needed.
        ]
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
    }))
    
    # (pkgs.nerd-fonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.protonvpn-gui
    pkgs.gnome-bluetooth
    pkgs.hyprpanel
    pkgs.nitch
    pkgs.neofetch
    pkgs.github-cli
    pkgs.neovide
    inputs.wezterm.packages.${pkgs.system}.default
    inputs.zen-browser.packages."${pkgs.system}".default
    inputs.ags.packages."${pkgs.system}".default
    inputs.astal.packages."${pkgs.system}".default
    inputs.nyxexprs.packages.${pkgs.system}.ani-cli
    #inputs.ghostty.packages.${pkgs.system}.default
    pkgs.gpu-screen-recorder
    pkgs.vscodium
    pkgs.libqalculate
    pkgs.libdbusmenu-gtk3
    pkgs.dbus-glib
    pkgs.gtkmm3
    pkgs.gtkmm4
    pkgs.gtkmm2
    pkgs.komikku
    pkgs.mangal
    pkgs.mangareader
    pkgs.gowall
    
  ];

  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/antonio/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR="nvim";
     TERMINAL="kitty";
     VISUAL="codium";
     BROWSER="firefox";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
