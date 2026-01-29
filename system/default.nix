{
  config,
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
    package = lib.mkDefault pkgs.ollama;
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
  networking.firewall.allowedTCPPorts = [
    22 # SSH
    5900 # VNC
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.ccache.enable = true;
  programs.ccache.cacheDir = "/nix/var/cache/ccache";
  nix.settings.extra-sandbox-paths = [ config.programs.ccache.cacheDir ];

  nix.settings.trusted-users = [ "@wheel" ];

  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "build.solarpi.ie";
      sshUser = "builder";
      protocol = "ssh-ng";

      systems = [ "aarch64-linux" ];

      maxJobs = 4;
      speedFactor = 2;

      supportedFeatures = [
        "big-parallel"
        "kvm"
        "nixos-test"
      ];
    }
  ];
  services.fail2ban.enable = true;
  # programs.ssh.extraConfig = ''
  #   Host build.solarpi.ie
  #     User builder
  #     ControlMaster auto
  #     ControlPersist 10m
  #     ControlPath /run/ssh-control/%r@%h:%p
  # '';
}
