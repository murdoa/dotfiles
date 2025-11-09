{
  lib,
  pkgs,
  ...
}:
{

  home.packages = [
    pkgs.libreoffice
  ];

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
    defaultApplications = {
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
    };
  };
  
  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      show-image-thumbnails = "always";
    };
  };
}
