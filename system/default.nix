{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./graphics.nix
  ];


  environment.systemPackages = with pkgs; [
    screen
  ];

  # mDNS resolver
  services.resolved = {
    enable = true;
  };

  services.udev.extraRules = ''
    # DSLogic devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a0e", ATTR{idProduct}=="0034", MODE="0666"
  '';

}
