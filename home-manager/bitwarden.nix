{
  config,
  pkgs,
  ...
}: let
  # https://bitwarden.com/help/ssh-agent/#configure-bitwarden-ssh-agent
  socketPath =
    if pkgs.stdenv.hostPlatform.isLinux
    then ".bitwarden-ssh-agent.sock"
    else "Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock";
in {
  sshAuthSock.initialization = {
    bash = ''export SSH_AUTH_SOCK="${config.home.homeDirectory}/${socketPath}"'';
    fish = ''set -x SSH_AUTH_SOCK "${config.home.homeDirectory}/${socketPath}"'';
  };
}
