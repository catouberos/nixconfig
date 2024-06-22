{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./terminal
    ./utility
    ./nnn.nix
  ];

  home.packages = with pkgs; [
    bat
    eza
    imagemagick
    yt-dlp
  ];

  programs = {
    tmux = {
      enable = true;
    };
    btop.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      functions = {
        fish_user_key_bindings = "fish_vi_key_bindings";

        # eza aliases
        l = "eza --icons";
        ll = "eza --icons -l";
        lt = "eza --icons -t";
      };
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
    git = {
      enable = true;
      userEmail = "khoanguyen.do@outlook.com";
      userName = "Nguyen Do";
      extraConfig = {
        gpg.format = "ssh";
        gpg."ssh".program = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.isLinux "${pkgs._1password-gui}/bin/op-ssh-sign")
          (lib.mkIf pkgs.stdenv.isDarwin "/Applications/1Password.app/Contents/MacOS/op-ssh-sign")
        ];
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICaumQv5SNC23QI8UytovjkssAor+yxQLixCGqVkk4vJ";
        commit.gpgsign = true;
      };
    };
  };
}
