{
  config,
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

    ./hardware-configuration.nix
    ../../modules/virtualisation/podman.nix
    ../../modules/virtualisation/container/filebrowser.nix
    ../../modules/virtualisation/container/flood.nix
    ../../modules/services/grafana.nix
    ../../modules/services/transmission.nix
    ../../modules/services/rtorrent.nix
    ../../modules/services/navidrome.nix
    ../../modules/services/jellyfin.nix
    ../../modules/services/komga.nix
    ../../modules/services/inadyn.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "shinobu";
    # temporarily
    enableIPv6 = false;
    networkmanager = {
      enable = true;
    };
    # TODO: check https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/11
    # resolvconf.enable = false;
    firewall = {
      enable = true;
      # http https NFSv4 pod-flood filebrowser
      allowedTCPPorts = [80 443 2049 3000 8080];
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
    ];
    config.allowUnfree = true;
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
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
  sops.secrets.cloudflare_tokens = {
    mode = "0440";
    owner = config.users.users.inadyn.name;
    group = config.users.users.inadyn.group;
  };

  hardware = {
    graphics.enable = true;
  };

  fileSystems = {
    "/mnt/wdpurple" = {
      device = "/dev/disk/by-uuid/94f0ee25-b428-4583-9523-2b3efa7ce1fa";
      fsType = "ext4";
      options = [
        "users" # Allows any user to mount and unmount
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
    fail2ban = {
      # TODO: check when fix
      enable = false;
      ignoreIP = [
        "192.168.0.0/16"
      ];
    };
    nfs = {
      server = {
        enable = true;
        exports = ''
          /export 192.168.0.1/24(insecure,ro,sync,no_subtree_check,crossmnt,fsid=0)
          /export/wdpurple 192.168.0.0/24(insecure,ro,sync,no_subtree_check)
        '';
      };
    };
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
