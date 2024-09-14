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
    };
    btop = {
      enable = true;
      package = pkgs.btop.override {rocmSupport = true;};
    };
    fzf.enable = true;
    bat.enable = true;
    eza = {
      enable = true;
      icons = true;
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
