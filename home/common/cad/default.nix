{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./3d-printing.nix
    ./simulation.nix
  ];

  # Required for Windows App
  home.packages = with pkgs; [
    wineWowPackages.stable
    winetricks
    samba
    gawk
    cabextract
    coreutils
    curl
    p7zip
    polkit
    spacenavd
    wget
    xdg-utils
    bc
  ];

}
