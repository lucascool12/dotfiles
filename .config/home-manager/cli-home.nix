{ config, pkgs, unstable-pkgs, ... }:
{
  home.packages = with pkgs; [
    # git
    neovim
    unzip
    yadm
    btop
  ];
  home.shellAliases = {
    gwip = ''git add -u; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'';
    gunwip = ''git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'';
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        export EDITOR="nvim"
        function gunwipall() {
          local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H)

          # Check if a commit without "--wip--" was found and it's not the same as HEAD
          if [[ "$_commit" != "$(git rev-parse HEAD)" ]]; then
            git reset $_commit || return 1
          fi
        }
      '';
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
    git = {
      enable = true;
      userName = "Lucas Van Laer";
      userEmail = "lucas.van.laer@gmail.com";
      ignores = [".envrc" ".direnv"];
      extraConfig = {
        merge = {
          tool = "nvim";
        };
        rerere.enable = true;
        rebase.updateRefs = true;
        credential.helper = "keepassxc --git-groups";
      };
    };
  };
  services.ssh-agent.enable = true;

  programs.starship.enable = true;

  imports = [
    ./cli-modules
  ];
}
