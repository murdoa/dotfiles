{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./simulation.nix
  ];

  home.packages = with pkgs; [
    freecad
  ];

}
