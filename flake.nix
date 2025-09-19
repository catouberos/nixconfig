{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix";
    sops-nix.url = "github:Mic92/sops-nix";
    naersk.url = "github:nix-community/naersk";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default-linux";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    sops-nix,
    apple-silicon,
    mac-app-util,
    auto-cpufreq,
    systems,
    ...
  } @ inputs: let
    inherit (self) outputs;

    forEachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = nixpkgs.lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
    );
  in {
    overlays = import ./overlays {inherit inputs outputs;};

    formatter = forEachSystem (pkgs: pkgs.alejandra);

    nixosConfigurations = {
      # main PC
      fishtank = nixpkgs.lib.nixosSystem {
        modules = [./hosts/fishtank];
        specialArgs = {inherit inputs outputs;};
      };

      # air but linux
      tomori = nixpkgs.lib.nixosSystem {
        modules = [./hosts/tomori auto-cpufreq.nixosModules.default];
        specialArgs = {inherit inputs outputs;};
      };

      # old surface go
      sfgo = nixpkgs.lib.nixosSystem {
        modules = [./hosts/sfgo];
        specialArgs = {inherit inputs outputs;};
      };

      # homelab
      shinobu = nixpkgs.lib.nixosSystem {
        modules = [./hosts/shinobu];
        specialArgs = {inherit inputs outputs;};
      };

      # homelab
      araragi = nixpkgs.lib.nixosSystem {
        modules = [./hosts/araragi];
        specialArgs = {inherit inputs outputs;};
      };
    };

    darwinConfigurations = {
      # macbook
      air = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs;};
        modules = [mac-app-util.darwinModules.default ./hosts/air];
      };
    };
  };
}
