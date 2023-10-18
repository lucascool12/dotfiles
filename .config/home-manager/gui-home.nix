{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    keepassxc
    syncthing
    zotero
    firefox
    thunderbird
    eid-mw
    ccid
    rofi
    teams
    git-credential-keepassxc
    thunderbird
    discord
    nerdfonts
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
