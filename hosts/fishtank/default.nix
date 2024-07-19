{
  pkgs,
  inputs,
  outputs,
  ...
}: let
  naersk' = pkgs.callPackage inputs.naersk {};
in {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.home-manager.nixosModules.default
    inputs.stylix.nixosModules.stylix
    inputs.sops-nix.nixosModules.sops

    ./hardware-configuration.nix
    ../../modules/gaming
    ../../modules/security
    ../../modules/virtualisation
    ../../modules/rgb.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "fishtank";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    # encrypted dns
    nameservers = ["127.0.0.1" "::1"];
    # TODO: check https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/11
    # resolvconf.enable = false;
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
    pam.services.login.enableGnomeKeyring = true;
  };

  # sops
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/home/catou/.config/sops/age/keys.txt";
  sops.secrets.cloudflare_tokens = {};

  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  stylix = {
    enable = true;
    image = ./wallpaper.png;
    polarity = "dark";
  };

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    dbus.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    mullvad-vpn.enable = true;
    nscd.enableNsncd = false;
    # encrypted dns
    dnscrypt-proxy2 = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;

        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        };

        server_names = ["mullvad-adblock-doh" "nextdns" "nextdns-ipv6"];
      };
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  fileSystems = {
    "/mnt/wdpurple" = {
      device = "192.168.1.69:/wdpurple";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };

    "/mnt/samsung860" = {
      device = "/dev/disk/by-uuid/ae9d72ed-1bf6-41e0-b8ba-fe04dcaa695d";
      fsType = "ext4";
      options = [
        "users" # Allows any user to mount and unmount
        "nofail" # Prevent system from failing if this drive doesn't mount
      ];
    };
  };

  programs = {
    dconf.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  users.users.catou = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "gamemode" "libvirtd"];
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
    pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
    systemPackages =
      (with pkgs; [
        coreutils
        killall
        vim
        alejandra
        wget
        tree

        util-linux
        vulkan-tools
        exfat

        ffmpeg-full

        #misc
        cabextract
        cifs-utils
        usbutils
      ])
      ++ [
        (naersk'.buildPackage {
          src = pkgs.fetchFromGitHub {
            owner = "kuroahna";
            repo = "mpv_websocket";
            rev = "0.2.0";
            hash = "sha256-yqZdLCAv9hP6ZMuNcgy2w8CYK/cNGMwpCE/0s2ELNTA=";
          };
        })
      ];
    variables = {
      # track https://github.com/swaywm/sway/issues/8143
      GTK_IM_MODULE = "fcitx";
    };
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
