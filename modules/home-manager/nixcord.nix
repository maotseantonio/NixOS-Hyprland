{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeManagerModules.nixcord
  ];
  programs.nixcord = {
    enable = true;
    vesktop = {
      enable = true;
      settings = {
	discordBranch = "canary";
        staticTitle = false;
        splashTheming = true;
        splashColor = "rgb(186, 194, 222)";
        splashBackground = "rgb(30, 30, 46)";
        arRPC = false;
        minimizeToTray = true;	
     };
    };
    config = {
      themeLinks = [
         "https://raw.githubusercontent.com/maotseantonio/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-mocha.theme.css"
      ];
      frameless = true;
      enabledThemes = ["midnight-catppuccin-mocha.theme.css"];
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
}
