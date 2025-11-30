{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.ghidra
    pkgs.okteta
  ];

}
