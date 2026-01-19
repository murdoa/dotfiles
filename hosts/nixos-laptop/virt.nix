{
  lib,
  pkgs,
  config,
  mainUser,
  ...
}:
let
  cpu_platform = "intel";
in
{
  boot = {
    kernelModules = [
      "kvm-${cpu_platform}"
    ];
    kernelParams = [
      "kvm.ignore_msrs=1"
    ];
  };

  # Enable virtualisation programs. These will be used by virt-manager to run your VM.
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      extraConfig = ''
        user="${mainUser}"
      '';

      # Don't start any VMs automatically on boot.
      onBoot = "ignore";
      # Stop all running VMs on shutdown.
      onShutdown = "shutdown";

      qemu = {
        package = pkgs.qemu_kvm;
      };
    };
  };

  users.users.${mainUser}.extraGroups = [
    "qemu-libvirtd"
    "libvirtd"
    "disk"
  ];
  programs.virt-manager.enable = true;
}
