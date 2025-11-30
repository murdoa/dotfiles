{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.gmsh
    pkgs.elmerfem
    pkgs.paraview
  ];

}
