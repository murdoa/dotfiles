{
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.playerctl
  ];

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;

    settings = [
      {
        layer = "top";
        position = "top";
        mod = "dock";
        exclusive = true;
        passthrough = false;
        gtk-layer-shell = true;

        height = 30;
        spacing = 16;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
          "hyprland/scratchpad"
        ];

        modules-center = [ "hyprland/window" ];

        modules-right = [
          "custom/media"
          "network"
          "battery"
          "group/group-power"
        ];

        network = {
          tooltip = true;
          tooltip-format = "{ipaddr}";
        };

        "custom/media" = {
          format = "{}";
          interval = 10;
          exec = "${scripts/media.sh}";
        };

        "group/group-power" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "drawer-child";
            transition-left-to-right = true;
          };
          modules = [
            "custom/power" # First element is the "group leader" and won't ever be hidden
            "custom/logout"
            "custom/lock"
            "custom/sleep"
            "custom/reboot"
          ];
        };

        "custom/logout" = {
          format = "Logout";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };
        "custom/lock" = {
          format = "Lock";
          tooltip = false;
          on-click = "hyprlock";
        };
        "custom/sleep" = {
          format = "Sleep";
          tooltip = false;
          on-click = "systemctl suspend";
        };
        "custom/reboot" = {
          format = "Reboot";
          tooltip = false;
          on-click = "systemctl reboot";
        };
        "custom/power" = {
          format = "Power";
          tooltip = false;
          on-click = "systemctl poweroff";
        };

      }
    ];
  };
}
