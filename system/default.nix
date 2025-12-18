{
  lib,
  pkgs,
  mainUser,
  ssh-keys,
  ...
}:
{
  imports = [
    ./graphics.nix
  ];

  environment.systemPackages = with pkgs; [
    screen
    usbutils
    jq
  ];

  # mDNS resolver
  services.resolved = {
    enable = true;
  };

  services.udev.extraRules = ''
    # DSLogic devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a0e", ATTR{idProduct}=="0034", MODE="0666"
  '';

  programs.kdeconnect.enable = true;

  services.ollama = {
    enable = true;
  };

  virtualisation.docker = {
    enable = false;
    # Use the rootless mode - run Docker daemon as non-root user
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.users.${mainUser} = {
    openssh.authorizedKeys.keyFiles = [ ssh-keys.outPath ];
    extraGroups = [ "docker" ];
  };
}
