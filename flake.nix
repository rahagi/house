{
  description = "Just get a house 4Head";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-24.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-deprecated,
    chaotic,
    home-manager,
    nix-alien,
    ...
  }: let
    hosts = [
      {
        name = "guinea-pig";
        system = "x86_64-linux";
        path = ./hosts/guinea-pig;
        homePath = ./home;
      }
      {
        name = "x260";
        system = "x86_64-linux";
        path = ./hosts/x260;
        homePath = ./hosts/x260/home;
      }
      {
        name = "blackbox";
        system = "x86_64-linux";
        path = ./hosts/blackbox;
        homePath = ./hosts/blackbox/home;
      }
    ];

    nixosConfigurations = builtins.listToAttrs (map (host: let
        pkgs-stable = import nixpkgs-stable {
          system = host.system;
          config.allowUnfree = true;
        };
        pkgs-deprecated = import nixpkgs-deprecated {
          system = host.system;
          config.allowUnfree = true;
        };
      in {
        name = host.name;
        value = nixpkgs.lib.nixosSystem rec {
          system = host.system;
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit pkgs-stable;
            inherit pkgs-deprecated;
          };
          modules = [
            host.path
            chaotic.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit system;
                inherit pkgs-stable;
                inherit pkgs-deprecated;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.rhg = import host.homePath;
            }
          ];
        };
      })
      hosts);
  in {
    nixosConfigurations = nixosConfigurations;
  };
}
