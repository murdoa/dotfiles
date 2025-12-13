{
  lib,
  pkgs,
  ...
}:
{
  services.onedrive = {
    enable = true;
    settings = { };
  };
}
