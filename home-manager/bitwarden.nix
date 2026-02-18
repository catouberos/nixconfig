{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      forwardAgent = true;
      identityAgent =
        # https://bitwarden.com/help/ssh-agent/#configure-bitwarden-ssh-agent
        if pkgs.stdenv.hostPlatform.isLinux
        then "~/.bitwarden-ssh-agent.sock"
        else "~/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
    };
  };
}
