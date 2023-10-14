{ config, pkgs, ... }:
{
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.packages = with pkgs; [
    git
    keepassxc
    neovim
    syncthing
    unzip
    yadm
    zotero
    firefox
    thunderbird
    nerdfonts
    eid-mw
    ccid
    nix-direnv
    btop
    rofi
    teams
    git-credential-keepassxc
    thunderbird
    # (nerdfonts.override { fonts = [ "DejaVuSansMono" ]; })
  ];
  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };

  home.stateVersion = "23.05";
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
    };
  };

  programs.starship.enable = true;

  imports = [
    ./modules
  ];
}
