{
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
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

  boot = {
    kernelPackages = pkgs.linuxPackages_testing;
    kernelModules = ["snd" "snd-timer" "snd-pcm" "snd-aloop"];
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth = {
      enable = true;
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # extraModulePackages = with config.boot.kernelPackages; [rtl8821au];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;
  };

  networking = {
    hostName = "fishtank";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
    };
  };

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = ["ja_JP.UTF-8/UTF-8" "vi_VN/UTF-8"];
  };

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
    pam = {
      services = {
        login.enableGnomeKeyring = true;
        # https://wiki.nixos.org/wiki/Sway#Swaylock_cannot_be_unlocked_with_the_correct_password
        swaylock = {};
      };
      # https://wiki.nixos.org/wiki/Sway#Inferior_performance_compared_to_other_distributions
      loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
    };
  };

  # sops
  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.age.keyFile = "/home/catou/.config/sops/age/keys.txt";
  sops.secrets.cloudflare_tokens = {};

  hardware = {
    graphics.enable = true;
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
      };
      pulse.enable = true;
      jack.enable = true;
      extraConfig = {
        pipewire = {
          "0-alsa-loopback" = {
            "context.properties" = {
              "default.clock.rate" = 192000;
              "vm.overrides" = {
                "default.clock.min-quantum" = 4096;
              };
            };
            "context.objects" = [
              {
                factory = "adapter";
                args = {
                  "factory.name" = "api.alsa.pcm.sink";
                  "node.name" = "alsa-sink";
                  "node.description" = "Alsa Loopback";
                  "media.class" = "Audio/Sink";
                  "api.alsa.path" = "hw:Loopback,0,0";
                  "audio.format" = "S32LE";
                  "audio.rate" = 192000;
                  "audio.channels" = 2;
                };
              }
            ];
          };
          "10-clock-rate" = {
            "context.properties" = {
              "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000];
            };
          };
        };
      };
    };
    dbus.enable = true;
    gnome.gnome-keyring.enable = true;
    udisks2.enable = true;
    mullvad-vpn.enable = true;
    tailscale.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = ["catou"]; # Allows all users by default. Can be [ "user1" "user2" ]
        AllowAgentForwarding = true;
      };
    };
  };

  fileSystems = {
    "/mnt/wdpurple" = {
      device = "192.168.0.69:/wdpurple";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
    "/mnt/samsung860" = {
      device = "192.168.0.69:/samsung860";
      fsType = "nfs";
      options = ["x-systemd.automount" "noauto"];
    };
  };

  programs = {
    dconf.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    adb.enable = true;
  };

  users.users.catou = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "gamemode" "libvirtd" "adbusers"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIADAlbdEFy+qGrgOfffqnSNAF8W7ozq36M3R0JtBclFV"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKrwXjRy8QWobQ3tFwy8ombcT0K1kbZzFxX/fiYhqeNG"
    ];
  };

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "backup";
    users.catou = {
      imports = [./home.nix inputs.nixvim.homeModules.nixvim];
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

      util-linux
      vulkan-tools

      ffmpeg-full
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
