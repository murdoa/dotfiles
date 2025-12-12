{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.git
    pkgs.lazygit
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "murdoa";
    userEmail = "murdoa@protonmail.com";
  };
}
