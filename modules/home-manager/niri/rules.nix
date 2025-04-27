{...}: let
  mkMatchRule = {
    appId,
    title ? "",
    openFloating ? false,
  }: let
    baseRule = {
      matches = [
        {
          app-id = appId;
          inherit title;
        }
      ];
    };
    floatingRule =
      if openFloating
      then {open-floating = true;}
      else {};
  in
    baseRule // floatingRule;

  openFloatingAppIds = [
    "^(pwvucontrol)"
    "^(Volume Control)"
    "^(dialog)"
    "^(file_progress)"
    "^(confirm)"
    "^(download)"
    "^(error)"
    "^(notification)"
    "^(thunar)"
    "^(discord)"
    "^(spotify)"
  ];

  floatingRules = builtins.map (appId:
    mkMatchRule {
      appId = appId;
      openFloating = true;
    })
  openFloatingAppIds;

  windowRules = [
    {
      geometry-corner-radius = let
        radius = 1.0;
      in {
        bottom-left = radius;
        bottom-right = radius;
        top-left = radius;
        top-right = radius;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [
        {is-floating = true;}
      ];
      shadow.enable = true;
    }
    {
      matches = [
        {
          is-window-cast-target = true;
        }
      ];
      focus-ring = {
        active.color = "#f38ba8";
        inactive.color = "#a9b1d600 ";
      };

      border = {
        inactive.color = "#a9b1d600 ";
      };

      shadow = {
        color = "#f38ba800 ";
      };

      tab-indicator = {
        active.color = "#f38ba8";
        inactive.color = "#a9b1d600";
      };
    }
    {
      matches = [{app-id = "org.telegram.desktop";}];
      block-out-from = "screencast";
    }
    {
      matches = [{app-id = "app.drey.PaperPlane";}];
      block-out-from = "screencast";
    }
    {
      matches = [
        {app-id = "^(zen|firefox|chromium-browser|chrome-.*|zen-.*)$";}
        {app-id = "^(xdg-desktop-portal-gtk)$";}
      ];
      scroll-factor = 0.85;
    }
    {
      matches = [
        {app-id = "^(zen|firefox|equibop|chromium-browser|edge|chrome-.*|zen-.*)$";}
      ];
      open-maximized = true;
    }
    {
      matches = [
        {
          app-id = "firefox$";
          title = "^Picture-in-Picture$";
        }
        {
          app-id = "zen-.*$";
          title = "^Picture-in-Picture$";
        }
        {title = "^Picture in picture$";}
        {title = "^Discord Popout$";}
      ];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "top-right";
      };
    }
    {
        matches = [
            {app-id = "^(org.wezfurlong.wezterm)$";}
            {app-id = "^(kitty)$";}
            {app-id = "^(com.mitchellh.ghostty)$";}
        ];
        opacity = 0.96;
    }
  ];
in {
  programs.niri.settings.window-rules = windowRules ++ floatingRules;
}
