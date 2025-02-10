{
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.home-manager.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    inputs.nix-minecraft.nixosModules.minecraft-servers

    ./hardware-configuration.nix
    ../../modules/virtualisation/docker.nix
    ../../modules/virtualisation/container/lms.nix
    ../../modules/services/transmission.nix
    ../../modules/services/rtorrent.nix
    ../../modules/services/navidrome.nix
    ../../modules/services/jellyfin.nix
    ../../modules/services/komga.nix
    ../../modules/services/immich.nix
    ../../modules/services/flood.nix
    ../../modules/services/minecraft.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "shinobu";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      # http https NFSv4
      allowedTCPPorts = [80 443 2049];
    };
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
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    overlays = [
      outputs.overlays.modifications
      inputs.nix-minecraft.overlay
    ];
    config.allowUnfree = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.loginLimits = [
      {
        domain = "*";
        item = "nofile";
        type = "-";
        value = "32768";
      }
    ];
  };

  # sops
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };
  environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

  fileSystems = {
    "/mnt/wdpurple" = {
      device = "/dev/disk/by-uuid/94f0ee25-b428-4583-9523-2b3efa7ce1fa";
      fsType = "ext4";
      options = [
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
      ];
    };

    "/mnt/wdblue" = {
      device = "/dev/disk/by-uuid/e71d6700-cdfe-4ab3-9452-00d38b167245";
      fsType = "btrfs";
      options = [
        "users" # Allows any user to mount and unmount
        "compress=zstd" # btrfs compress
        "nofail" # Prevent system from failing if this drive doesn't mount
      ];
    };

    "/mnt/samsung860" = {
      device = "/dev/disk/by-uuid/5840f1f0-6c32-457e-ac1a-343f41a663da";
      fsType = "ext4";
      options = [
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
      ];
    };

    "/export/wdpurple" = {
      device = "/mnt/wdpurple";
      options = ["bind"];
    };

    "/export/wdblue" = {
      device = "/mnt/wdblue";
      options = ["bind"];
    };

    "/export/samsung860" = {
      device = "/mnt/samsung860";
      options = ["bind"];
    };
  };

  services = {
    dbus.enable = true;
    udisks2.enable = true;
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["catou"]; # Allows all users by default. Can be [ "user1" "user2" ]
      };
    };
    nfs = {
      server = {
        enable = true;
        exports = ''
          /export 192.168.0.1/24(insecure,ro,sync,no_subtree_check,crossmnt,fsid=0)
          /export/wdpurple 192.168.0.0/24(insecure,ro,sync,no_subtree_check)
          /export/wdblue 192.168.0.0/24(insecure,ro,sync,no_subtree_check)
        '';
      };
    };
    transmission.settings.download-dir = "/mnt/wdpurple/Torrents";
    rtorrent.downloadDir = "/mnt/wdblue/Torrents";
    navidrome.settings.MusicFolder = "/mnt/samsung860/Music";
    tailscale.enable = true;
  };

  systemd.services = {
    transmission.serviceConfig.BindPaths = ["/mnt/wdpurple" "/mnt/samsung860"];
  };

  programs = {
    dconf.enable = true;
    mtr.enable = true;
  };

  users.users.catou = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADAlbdEFy+qGrgOfffqnSNAF8W7ozq36M3R0JtBclFV"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKrwXjRy8QWobQ3tFwy8ombcT0K1kbZzFxX/fiYhqeNG"
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

      # linux-firmware
      vulkan-tools
      exfat

      ffmpeg-full

      #misc
      cabextract
      cifs-utils
      usbutils
      powertop
      rclone
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
