{
  lib,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    dtc
  ];

}
