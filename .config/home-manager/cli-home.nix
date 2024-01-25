{ config, pkgs, unstable-pkgs, ... }:
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
    tmux = {
      enable = true;
      escapeTime = 0;
      mouse = true;
    };
    ssh = {
      enable = true;
    };
  };
  services.ssh-agent.enable = true;

  programs.bash.initExtra = ''
  export EDITOR="nvim"
'';

  programs.starship.enable = true;

  imports = [
    ./cli-modules
  ];
}
