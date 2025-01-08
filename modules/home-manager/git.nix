{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "maotseantonio";
    userEmail = "thetzinantonio@gmail.com";
  };
}
