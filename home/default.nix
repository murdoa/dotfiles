{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cad
    ./dev
    ./web
    ./wm
    ./gnome.nix
    ./messaging.nix
    ./music.nix
    ./shell.nix
    ./productivity.nix
    ./utils.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
