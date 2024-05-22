{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    nix-darwin,
    home-manager,
    nixos-hardware,
    stylix,
    ...
  } @ inputs: let
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      fishtank = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          stylix.nixosModules.stylix
          ./hosts/fishtank/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-cpu-intel-cpu-only
          nixos-hardware.nixosModules.common-pc-ssd
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              backupFileExtension = "backup";
              users.catou = {
                imports = [./hosts/fishtank/home.nix nixvim.homeManagerModules.nixvim];
              };
            };
          }
        ];
      };
    };

    darwinConfigurations = {
      air = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/air/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              backupFileExtension = "backup";
              users.catou = {
                imports = [./hosts/air/home.nix nixvim.homeManagerModules.nixvim];
              };
            };
          }
        ];
      };
    };
  };
}
