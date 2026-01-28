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
    ./services.nix
  ];

  networking.nameservers = [
    "1.1.1.1"
    "9.9.9.9"
  ];

  environment.systemPackages = with pkgs; [
    screen
    usbutils
    jq
    wireshark
  ];

  # mDNS resolver
  services.resolved = {
    enable = true;
  };

  services.udev.extraRules = ''
    # DSLogic devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="2a0e", ATTR{idProduct}=="0034", MODE="0666"
    # GARMIN devices
    SUBSYSTEM=="usb", ATTR{idVendor}=="091e", MODE="0666"
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

  programs.wireshark.enable = true;

  users.users.${mainUser} = {
    openssh.authorizedKeys.keyFiles = [ ssh-keys.outPath ];
    extraGroups = [
      "docker"
      "wireshark"
    ];
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh.enable = true;
}
