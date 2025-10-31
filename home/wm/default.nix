{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./waybar
  ];

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

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };

  programs.walker = {
    enable = true;
  };
}
