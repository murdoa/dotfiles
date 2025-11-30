{
  lib,
  pkgs,
  ...
}:
{
  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "icon-view";
      migrated-gtk-settings = true;
      search-filter-time-type = "last_modified";
      show-image-thumbnails = "always";
    };
  };
}
