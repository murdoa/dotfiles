{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./cad
    ./dev
    ./web
    ./wm
    ./gnome.nix
    ./graphics.nix
    ./messaging.nix
    ./music.nix
    ./shell.nix
    ./services.nix
    ./productivity.nix
    ./utils.nix
  ];

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
    };
  };

  nixpkgs.config.allowUnfree = true;
}
