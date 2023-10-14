{
  description = "Home Manager configuration of lucas";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
        url = "github:nixos/nixpkgs/nixos-23.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    blesh = {
      url = "https://github.com/akinomyoga/ble.sh/releases/download/v0.4.0-devel3/ble-0.4.0-devel3.tar.xz";
      flake = false;
    };
  };

  outputs = { nixpkgs, home-manager, blesh, ... }:
    let
      system = "x86_64-linux";
      legacyPackages = nixpkgs.lib.genAttrs [ "x86_64-linux" ] (system:
        import nixpkgs {
          inherit system;
          # NOTE: Using `nixpkgs.config` in your NixOS config won't work
          # Instead, you should set nixpkgs configs here
          # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)

          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
                "teams-1.5.00.23861"
            ];
          };
        }
      );
     pkgs = legacyPackages.${system};
    in {
      homeConfigurations."lucas" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit blesh;
        };
      };
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
}
