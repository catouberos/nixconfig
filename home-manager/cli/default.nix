{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./terminal
    ./utility
    ./compression.nix
    ./fish.nix
    ./lf.nix
  ];

  home.packages = with pkgs; [
    imagemagick
    sops
    mkvtoolnix-cli
  ];

  programs = {
    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '60' # minutes
          '';
        }
      ];
    };
    btop = {
      enable = true;
    };
    fzf.enable = true;
    bat.enable = true;
    eza = {
      enable = true;
      icons = "auto";
    };
    yt-dlp.enable = true;
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
