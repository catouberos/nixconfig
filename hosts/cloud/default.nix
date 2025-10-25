# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  outputs,
  pkgs,
  ...
}: let
  octoprint = pkgs.octoprint.python.withPackages (ps: [
    ps.octoprint
    ps.octoprint-bambuprinter
  ]);
in {
  imports = [
    inputs.home-manager.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  # nix.package = pkgs.nix;
  nix.enable = true;
  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
    ];
    config.allowUnfree = true;
  };

  programs = {
    fish.enable = true;
  };

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  users.users.catou.home = "/Users/catou";

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "backup";
    users.catou = {
      imports = [./home.nix inputs.nixvim.homeModules.nixvim];
    };
  };

  system = {
    primaryUser = "catou";
    # Set Git commit hash for darwin-version.
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
  };

  launchd.user.agents = {
    octoprint = {
      command = "${octoprint}/bin/octoprint serve --port 5001";
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/octoprint.out.log";
        StandardErrorPath = "/tmp/octoprint.err.log";
      };
    };
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
