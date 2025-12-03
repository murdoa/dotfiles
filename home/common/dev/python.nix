{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [
    pkgs.uv
    pkgs.python312
    pkgs.python312Packages.pip
  ];

}
