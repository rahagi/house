{
  description = "Just get a house 4Head";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-deprecated.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland/v0.54.2";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    nixpkgs-deprecated,
    home-manager,
    hyprland-plugins,
    ...
  }: let
    hosts = [
      {
        name = "blackbox";
        system = "x86_64-linux";
        path = ./hosts/blackbox;
        homePath = ./hosts/blackbox/home;
      }
      {
        name = "pi";
        system = "aarch64-linux";
        path = ./hosts/pi;
        homePath = ./hosts/pi/home;
      }
    ];

    nixosConfigurations =
      builtins.listToAttrs (map (host: let
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
              inherit hyprland-plugins;
            };
            modules = [
              host.path

              home-manager.nixosModules.home-manager
              {
                home-manager.extraSpecialArgs = {
                  inherit inputs;
                  inherit system;
                  inherit pkgs-stable;
                  inherit pkgs-deprecated;
                  inherit hyprland-plugins;
                };
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.rhg = import host.homePath;
              }
            ];
          };
        })
        hosts)
      // {
        pi-default-img = let
          pkgs-stable = import nixpkgs-stable {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
        in
          nixpkgs.lib.nixosSystem {
            system = "aarch64-linux";
            specialArgs = {
              inherit pkgs-stable;
              inputs = {
                sops-nix = inputs.sops-nix;
              };
            };
            modules = [
              {
                nixpkgs.config.allowUnsupportedSystem = true;
                nixpkgs.hostPlatform.system = "aarch64-linux";
                nixpkgs.buildPlatform.system = "x86_64-linux";
              }
              "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix"

              ./hosts/pi
              {
                sdImage.compressImage = false;
              }
            ];
          };
      };
  in {
    nixosConfigurations = nixosConfigurations;
  };
}
