{
  lib,
  pkgs,
  mainUser,
  ...
}:
{
  imports = [
    ./graphics.nix
  ];

  environment.systemPackages = with pkgs; [
    screen
    usbutils
  ];

  # mDNS resolver
  services.resolved = {
    enable = true;
  };

  services.udev.extraRules = ''
    # DSLogic devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a0e", ATTR{idProduct}=="0034", MODE="0666"
  '';

  virtualisation.docker = {
    enable = false;
    # Use the rootless mode - run Docker daemon as non-root user
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
  users.users.${mainUser}.extraGroups = [ "docker" ];

}
