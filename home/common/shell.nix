{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.zsh
    pkgs.oh-my-zsh
  ];

  programs.zsh = {
    enable = true;
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ ];
    theme = "agnoster";
  };
}
