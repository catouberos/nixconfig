{pkgs, ...}: {
  home.packages = with pkgs; [trash-cli];

  programs.lf = {
    enable = true;
    keybindings = {
      D = "trash";
    };
    commands = {
      trash = "%trash-put $fx";
      fg = ''
        ''${{
            cmd="${pkgs.ripgrep}/bin/rg --column --line-number --no-heading --color=always --smart-case"
            ${pkgs.fzf}/bin/fzf --ansi --disabled --layout=reverse --header="Search in files" --delimiter=: \
                --bind="start:reload([ -n {q} ] && $cmd -- {q} || true)" \
                --bind="change:reload([ -n {q} ] && $cmd -- {q} || true)" \
                --bind='enter:become(lf -remote "send $id select \"$(printf "%s" {1} | sed '\'''s/\\/\\\\/g;s/"/\\"/g'\''')\"")' \
                --preview='${pkgs.bat}/bin/bat -- {1}' # Use your favorite previewer here (bat, source-highlight, etc.), for example:
        }}
      '';
      on-select = ''
        &{{
            ${pkgs.lf}/bin/lf -remote "send $id set statfmt \"$(${pkgs.eza}/bin/eza -ld --color=always "$f" | sed 's/\\/\\\\/g;s/"/\\"/g')\""
        }}
      '';
      on-cd = ''
        &{{
            fmt="$(STARSHIP_SHELL=${pkgs.starship}/bin/starship prompt | sed 's/\\/\\\\/g;s/"/\\"/g')"
            ${pkgs.lf}/bin/lf -remote "send $id set promptfmt \"$fmt\""
        }}
      '';
    };
    settings = {
      ifs = "\n";
      icons = true;
      sixel = true;
    };
    previewer = {
      source = pkgs.writeShellScript "pv.sh" ''
        #!/bin/sh

        case "$(${pkgs.file}/bin/file -Lb --mime-type -- "$1")" in
          image/*)
            ${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
            exit 1
            ;;
        esac

        ${pkgs.pistol}/bin/pistol "$1"
      '';
    };
  };

  xdg.configFile = {
    "lf/colors" = {
      enable = true;
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gokcehan/lf/r32/etc/colors.example";
        hash = "sha256-cYJlXuRjuotQ1aynPG5+UGK2nBBNg/6xRiGs2mBpKeY=";
      };
    };
    "lf/icons" = {
      enable = true;
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/gokcehan/lf/r32/etc/icons.example";
        hash = "sha256-PZxDReQhwEeDRvSeLFhjGjRAy+Yc3GTXXL6OLP23gQQ=";
      };
    };
  };
}
