{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.rclone
    pkgs.keepassxc
  ];

}
