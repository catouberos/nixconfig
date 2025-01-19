{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    functions = {
      fish_user_key_bindings = "fish_vi_key_bindings";
      splitcue = lib.mkIf pkgs.stdenv.isLinux ''
        find . -name "*.cue" -exec sh -c 'exec ${pkgs.shntool}/bin/shnsplit -f "$1" -o flac -d "$(dirname "$1")" -t "%n %t" "''${1%.cue}.flac"' _ {} \; -exec sh -c 'rm "''${1%.cue}.flac"' _ {} \;
      '';
      nowebp = ''
        wget --header "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0" --header "Accept: image/avif,image/apng,image/svg+xml,image/,/*;q=0.8" $argv
      '';
      lf = {
        wraps = "lf";
        body = "cd \"$(command lf -print-last-dir $argv)\"";
      };
    };
  };
}
