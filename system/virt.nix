{
  lib,
  pkgs,
  config,
  mainUser,
  ...
}:
{
  users.users.${mainUser}.extraGroups = [ "libvirtd" ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
