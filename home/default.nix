{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cad
    ./dev
    ./music.nix
    ./shell.nix
    ./productivity.nix
    ./web
    ./wm
  ];

  nixpkgs.config.allowUnfree = true;
}
