{
  pkgs,
  lib,
  ...
}: let
  btopPackage =
    if pkgs.system == "x86_64-linux"
    then pkgs.btop-rocm
    else pkgs.btop;
in {
  imports = [
    ./compression.nix
    ./fish.nix
    ./lf.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    imagemagick
    sops
    mkvtoolnix-cli
    httpie
    grpcurl
    google-cloud-sdk
    tcld
    xan
    gh-markdown-preview
  ];

  programs = {
    btop = {
      enable = true;
      package = btopPackage;
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
