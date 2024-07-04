{pkgs, ...}: {
  home.packages = with pkgs; [trash-cli];

  programs.lf = {
    enable = true;
    keybindings = {
      D = "trash";
    };
    commands = {
      trash = "%trash-put $fx";
    };
    previewer = {
      source = pkgs.writeShellScript "pv.sh" ''
        #!/bin/sh

        case "$1" in
            *.tar*) ${pkgs.gnutar}/bin/tar tf "$1";;
            *.zip) ${pkgs.unzip}/bin/unzip -l "$1";;
            *.rar) ${pkgs.unrar}/bin/unrar l "$1";;
            *.7z) ${pkgs.p7zip}/bin/7z l "$1";;
            *.pdf) ${pkgs.poppler_utils}/bin/pdftotext "$1" -;;
            *) highlight -O ansi "$1" || cat "$1";;
        esac
      '';
    };
  };
}
