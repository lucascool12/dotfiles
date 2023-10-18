{ config, pkgs, ... }:
{
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
