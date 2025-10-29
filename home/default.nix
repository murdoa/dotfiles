{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./shell.nix
    ./dev
  ];
}
