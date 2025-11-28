{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nvidia.nix
  ];

  hardware.enableRedistributableFirmware = true;
}
