# fishtank Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "fishtank"; # Define your hostname.
    networkmanager = {
      enable = true;
      dns = "none";
    };
    nameservers = ["127.0.0.1" "::1"];
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
  nixpkgs.config.allowUnfree = true;

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
    pam.services.login.enableGnomeKeyring = true;
  };

  hardware = {
    opengl.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
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
    avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };
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

        server_names = ["mullvad-base-doh" "nextdns" "nextdns-ipv6"];
      };
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };

  programs = {
    dconf.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["catou"];
    };
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    gamemode = {
      enable = true;
      settings.general.inhibit_screensaver = 0;
    };
  };

  users.users.catou = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "gamemode"];
  };

  catppuccin.flavour = "macchiato";

  home-manager = {
    users = {
      "catou" = {
        imports = [./home.nix inputs.catppuccin.homeManagerModules.catppuccin inputs.nixvim.homeManagerModules.nixvim];
      };
    };
  };

  environment = {
    pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];
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
