{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      fish_user_key_bindings = "fish_vi_key_bindings";
      splitcue = ''
        find . -name "*.cue" -exec sh -c 'exec ${pkgs.shntool}/bin/shnsplit -f "$1" -o flac -d "$(dirname "$1")" -t "%n %t" "''${1%.cue}.flac" && exec ${pkgs.cuetools}/bin/cuetag.sh $1 *.flac' _ {} \;
      '';
    };
  };
}
