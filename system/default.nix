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
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh.enable = true;

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
 # programs.ssh.extraConfig = ''
 #   Host build.solarpi.ie
 #     User builder
 #     ControlMaster auto
 #     ControlPersist 10m
 #     ControlPath /run/ssh-control/%r@%h:%p
 # '';
}
