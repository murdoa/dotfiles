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
    ./vscode.nix
  ];
}
