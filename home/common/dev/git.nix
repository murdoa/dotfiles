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
    settings = {
      user = {
        name = "murdoa";
        email = "murdoa@protonmail.com";
      };
    };
  };
}
