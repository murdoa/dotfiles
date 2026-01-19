{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./3d-printing.nix
    ./simulation.nix
  ];

  home.packages = with pkgs; [
    freecad
  ];

}
