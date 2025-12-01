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
    style = builtins.readFile ./style-transparent.css;

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
          "mpris"
          "pulseaudio"
          "network"
          "clock"
          "group/group-battery"
          "group/group-power"
        ];

        "hyprland/window" = {
          format = "{}";
          "rewrite" = {
            "(.*) - Mozilla Firefox" = "🌎 $1";
            "(.*) - zsh" = "> [$1]";
          };
        };

        mpris = {
          format = "{status_icon}";
          tooltip-format = "{artist}: {title} [{position}/{length}]\n{player}: {status}";
          status-icons = {
            paused = "";
            playing = "";
          };
        };

        battery = {
          states = {
            # good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}%";
          format-full = "{capacity}%";
          format-charging = "{capacity}% 󱐋";
          format-plugged = "{capacity}% ";
          format-alt = "{time}";
          # format-good = ""; // An empty format will hide the module
          # format-full = "";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "group/group-battery" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 150;
            transition-left-to-right = false;
          };
          modules = [
            "battery"
            "power-profiles-daemon"
          ];
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        network = {
          tooltip = true;
          tooltip-format = "{ipaddr}";
        };

        "custom/media" = {
          format = "{}";
          interval = 10;
          exec = "${scripts/media.sh}";
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            headphones = "";
            handsfree = "";
            headset = "";
            phone = "";
            phone-muted = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
            ];
          };
          scroll-step = 1;
          on-click = "pavucontrol";
        };

        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = "";
            performance = "";
            balanced = "";
            power-saver = "";
          };
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
