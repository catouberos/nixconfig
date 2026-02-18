# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: let
  octoprint = pkgs.octoprint.python.withPackages (ps: [
    ps.octoprint
    ps.octoprint-bambuprinter
  ]);

  format = pkgs.formats.yaml {};
  configFile = format.generate "go2rtc.yaml" {
    streams = {
      a1mini = "exec:${pkgs.bambu-go2rtc}/bin/bambu-go2rtc";
    };
  };
in {
  imports = [
    inputs.home-manager.darwinModules.default
    inputs.sops-nix.darwinModules.sops
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

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.secrets."bambu/address" = {
    owner = config.system.primaryUser;
  };
  sops.secrets."bambu/access_code" = {
    owner = config.system.primaryUser;
  };

  environment.systemPackages = [pkgs.bambu-go2rtc];

  launchd.user.agents = {
    go2rtc = {
      # export PRINTER_ADDRESS=$(cat ${config.sops.secrets."bambu/address".path})
      # export PRINTER_ACCESS_CODE=$(cat ${config.sops.secrets."bambu/access_code".path})
      script = ''
        export PRINTER_ADDRESS=$(cat ${config.sops.secrets."bambu/address".path})
        export PRINTER_ACCESS_CODE=$(cat ${config.sops.secrets."bambu/access_code".path})
        ${pkgs.go2rtc}/bin/go2rtc -config ${configFile}
      '';
      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        StandardOutPath = "/tmp/go2rtc.out.log";
        StandardErrorPath = "/tmp/go2rtc.err.log";
      };
    };
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
