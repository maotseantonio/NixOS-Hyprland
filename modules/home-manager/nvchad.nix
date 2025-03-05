{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  programs.nvchad = {
    enable = true;
    neovim = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      nodePackages.bash-language-server
      #docker-compose-language-service
      #dockerfile-language-server-nodejs
      emmet-language-server
      nixd
      vscode-langservers-extracted
      typescript-language-server
      vue-language-server
    ];
    extraConfig = inputs.nvchad-on-steroids;
    hm-activation = true;
    backup = false;
  };
}
