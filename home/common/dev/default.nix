{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./ai.nix
    ./reverse.nix
    ./python.nix
    ./tmux.nix
    ./vscode.nix
  ];
}
