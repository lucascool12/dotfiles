{
  description = "Home Manager configuration of lucas";

  inputs = {
    nixpkgs = {
        url = "github:nixos/nixpkgs/nixos-23.05";
    };
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blesh = {
      url = "https://github.com/akinomyoga/ble.sh/releases/download/v0.4.0-devel3/ble-0.4.0-devel3.tar.xz";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, blesh, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
           inherit system;
           config = {
             allowUnfree = true;
             permittedInsecurePackages = [
               "teams-1.5.00.23861"
             ];
           };
         };
      in {
        packages = {
          homeConfigurations."lucas" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./gui-home.nix
              ./cli-home.nix
              ./common-home.nix
            ];
            extraSpecialArgs = {
              inherit blesh;
            };
          };
          homeConfigurations."lucas-cli" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./cli-home.nix
              ./common-home.nix
            ];
            extraSpecialArgs = {
              inherit blesh;
            };
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        };
     });
}
