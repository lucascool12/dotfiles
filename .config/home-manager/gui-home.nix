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
    git-credential-keepassxc
    thunderbird
    discord
    nerdfonts
    grim
    slurp
    zettlr
    texlive.combined.scheme-tetex
    pandoc
    chromium
    gnome.nautilus
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  # services.flatpak.enable = true;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["firefox.desktop"];
      "x-scheme-handler/mailto" = [ "userapp-Thunderbird-VY4WC2.desktop" ];
      "x-scheme-handler/mid" = [ "userapp-Thunderbird-VY4WC2.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = ["firefox.desktop"];
      "x-scheme-handler/mailto" = [ "userapp-Thunderbird-VY4WC2.desktop" ];
      "x-scheme-handler/mid" = [ "userapp-Thunderbird-VY4WC2.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/x-extension-htm" = [ "firefox.desktop" ];
      "application/x-extension-html" = [ "firefox.desktop" ];
      "application/x-extension-shtml" = [ "firefox.desktop" ];
      "application/xhtml+xml" = [ "firefox.desktop" ];
      "application/x-extension-xhtml" = [ "firefox.desktop" ];
      "application/x-extension-xht" = [ "firefox.desktop" ];
    };
  };
}
