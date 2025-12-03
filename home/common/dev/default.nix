{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./ai.nix
    ./formatting.nix
    ./git.nix
    ./reverse.nix
    ./python.nix
    ./tmux.nix
    ./vscode.nix
    ./cc.nix
  ];
}
