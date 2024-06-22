{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-pc-hdd
    inputs.home-manager.nixosModules.default

    ./hardware-configuration.nix
    ../../modules/virtualisation/podman.nix
    ../../modules/services/transmission.nix
    ../../modules/services/navidrome.nix
    ../../modules/services/jellyfin.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "shinobu"; # Define your hostname.
    networkmanager = {
      enable = true;
    };
    # TODO: check https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/11
    resolvconf.enable = false;
  };

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
    ];
    config.allowUnfree = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  hardware = {
    opengl.enable = true;
  };

  fileSystems."/mnt/wdpurple" = {
    device = "/dev/disk/by-uuid/94f0ee25-b428-4583-9523-2b3efa7ce1fa";
    fsType = "ext4";
    options = [
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  services = {
    dbus.enable = true;
    udisks2.enable = true;
    openssh = {
      enable = true;
      ports = [7979];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["catou"]; # Allows all users by default. Can be [ "user1" "user2" ]
      };
    };
  };

  programs = {
    dconf.enable = true;
    mtr.enable = true;
  };

  users.users.catou = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICaumQv5SNC23QI8UytovjkssAor+yxQLixCGqVkk4vJ"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "backup";
    users.catou = {
      imports = [./home.nix inputs.nixvim.homeManagerModules.nixvim];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      coreutils
      killall
      vim
      alejandra
      wget
      tree

      linux-firmware
      util-linux
      vulkan-tools
      exfat

      ffmpeg-full

      #misc
      cabextract
      cifs-utils
      usbutils
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
