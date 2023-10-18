{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    neovim
    unzip
    yadm
    btop
  ];

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
    };
    neovim = {
      defaultEditor = true;
    };
  };

  programs.starship.enable = true;

  imports = [
    ./cli-modules
  ];
}
