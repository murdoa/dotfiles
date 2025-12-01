{
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.playerctl
    pkgs.pavucontrol
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
          "pulseaudio"
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
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "phone-muted" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
            ];
          };
          "scroll-step" = 1;
          "on-click" = "pavucontrol";
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
            "custom/reboot"
            "custom/logout"
            "custom/sleep"
            "custom/lock"
          ];
        };

        "custom/logout" = {
          format = "󰗽";
          tooltip = false;
          on-click = "hyprctl dispatch exit";
        };
        "custom/lock" = {
          format = "";
          tooltip = false;
          on-click = "hyprlock";
        };
        "custom/sleep" = {
          format = "󰒲";
          tooltip = false;
          on-click = "systemctl suspend";
        };
        "custom/reboot" = {
          format = "󰜉";
          tooltip = false;
          on-click = "systemctl reboot";
        };
        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "systemctl poweroff";
        };

      }
    ];
  };
}
