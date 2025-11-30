{
  lib,
  pkgs,
  config,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.displayManager.defaultSession = "hyprland";
  # Enable GVFS for samba support
  services.gvfs.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = [
    pkgs.kitty
    pkgs.wofi
    pkgs.waybar
    pkgs.font-awesome
    pkgs.brightnessctl
  ];
}
