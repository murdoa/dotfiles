{
  lib,
  pkgs,
  ...
}:
{

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    liberation_ttf
    nerd-fonts.droid-sans-mono
    noto-fonts
    noto-fonts-emoji
    proggyfonts
  ];

  programs.waybar = {
    enable = true;
  };

  programs.walker = {
    enable = true;
  };
}
