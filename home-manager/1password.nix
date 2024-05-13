{
  pkgs,
  lib,
  ...
}: let
  onePassLinuxPath = "~/.1password/agent.sock";
  onePassDarwinPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in {
  programs.ssh = {
    enable = true;
    extraConfig = lib.mkMerge [
      (lib.mkIf pkgs.stdenv.isLinux
        ''
          Host *
            IdentityAgent "${onePassLinuxPath}"
        '')
      (lib.mkIf pkgs.stdenv.isDarwin
        ''
          Host *
            IdentityAgent "${onePassDarwinPath}"
        '')
    ];
  };
}
