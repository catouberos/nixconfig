{pkgs, ...}: {
  imports = [
    ./stylix.nix
    ./fonts.nix
    ./multimedia
    ./sway
    ./fcitx5.nix
    ./thunderbird.nix
    ./firefox.nix
    ./librewolf.nix
  ];

  home.packages = with pkgs; [
    ffsubsync
  ];

  programs = {
    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = [
        {
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          crxPath = pkgs.fetchzip {
            url = "https://github.com/gorhill/uBlock/releases/download/1.65.0/uBlock0_1.65.0.chromium.zip";
            hash = "sha256-/+cZpw7QN9f9G9BDgHeTSjssBOH5NqEYXgZEC2S+mwc=";
          };
          version = "1.65.0";
        }
      ];
      commandLineArgs = [
        "--ozone-platform-hint=auto"
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--gtk-version=4"
      ];
    };
  };
}
