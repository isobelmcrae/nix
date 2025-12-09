{
  description = "iso nixos config";
  nixConfig = {
    extra-substituters = [
      "https://nixos-apple-silicon.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
    accept-flake-config = true;
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nvim config
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nvf,
      ...
    }:
    let 
    mkSystem = { system, hostPath }: nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          hostPath
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.iso = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        kiwi = mkSystem {
          system = "aarch64-linux";
          hostPath = ./hosts/kiwi;
        };

        chocolate = mkSystem {
          system = "x86_64-linux";
          hostPath = ./hosts/chocolate;
        };
      };
    };
}
