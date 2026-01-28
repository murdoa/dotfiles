{
  lib,
  pkgs,
  mainUser,
  ssh-keys,
  ...
}:
{
  services.postgresql = {
    enable = true;
  };
  services.pgadmin = {
    enable = true;
    initialEmail = "murdoa@protonmail.com";
    initialPasswordFile = (builtins.toFile "password" "password");
  };
}
