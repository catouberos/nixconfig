{pkgs, ...}: {
  imports = [
    ./terminal
  ];

  home.packages = with pkgs; [
    unzip
    fastfetch
    bat
    eza
  ];

  programs = {
    tmux = {
      enable = true;
      catppuccin.enable = true;
    };
    btop.enable = true;
    nnn = {
      enable = true;
      package = pkgs.nnn.override {withNerdIcons = true;};
    };
    fish = {
      enable = true;
      catppuccin.enable = true;
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
      catppuccin.enable = true;
      enableFishIntegration = true;
    };
    git = {
      enable = true;
      userEmail = "khoanguyen.do@outlook.com";
      userName = "Nguyen Do";
      extraConfig = {
        gpg.format = "ssh";
        gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
    };
  };
}
