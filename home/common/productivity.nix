{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.libreoffice
    pkgs.imagemagick
  ];
  
}
