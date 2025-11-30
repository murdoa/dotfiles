{
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = lib.mkMerge [
    {
      general = {
        gaps_in = lib.mkOverride 50 5;
        gaps_out = lib.mkOverride 50 10;
        border_size = lib.mkOverride 50 1;
      };
      decoration = {
        rounding = lib.mkOverride 50 7;
      };
    }
  ];
}
