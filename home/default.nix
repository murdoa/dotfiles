{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./dev
    ./music.nix
    ./shell.nix
  ];
}
