{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    shellAliases = {
      l = "eza --icons";
      ll = "eza --icons -l";
      lt = "eza --icons -t";
    };
    functions = {
      fish_user_key_bindings = "fish_vi_key_bindings";
      splitcue = ''
        find . -name "*.cue" -exec sh -c 'exec shnsplit -f "$1" -o flac -d "$(dirname "$1")" -t "%n %t" "$\{1%.cue}.flac"' _ {} \;
      '';
    };
  };
}
