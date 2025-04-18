{ inputs, 
  pkgs,
  ...
}:
{
  imports = [inputs.walker.homeManagerModules.default];
  programs.walker = {
  enable = true;
  runAsService = true;

  # All options from the config.json can be used here.
  config = {
    search.placeholder = "Hi";
    ui.fullscreen = true;
    list = {
      height = 200;
    };
    websearch.prefix = "?";
    switcher.prefix = "/";
    style = ''
      * {
        color: #181825;
      }
    '';

  };

  # If this is not set the default styling is used.
 };
}
