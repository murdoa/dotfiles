{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.git
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "murdoa";
    userEmail = "murdoa@protonmail.com";
  };
}
