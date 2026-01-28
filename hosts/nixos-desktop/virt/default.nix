{
  lib,
  pkgs,
  config,
  mainUser,
  ...
}:
let
  cpu_platform = "amd";
  vfioIds = [
    "10de:2230"
    "10de:1aef"
  ];
in
{
  # Configure kernel options to make sure IOMMU & KVM support is on.
  boot = {
    kernelModules = [
      "kvm-${cpu_platform}"
      "vfio_virqfd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];
    kernelParams = [
      "${cpu_platform}_iommu=on"
      "${cpu_platform}_iommu=pt"
      "kvm.ignore_msrs=1"
    ];
    extraModprobeConfig = "
   	softdep nvidia pre: vfio vfio_pci
    options vfio-pci ids=${builtins.concatStringsSep "," vfioIds}
    ";
  };

  # Add a file for looking-glass to use later. This will allow for viewing the guest VM's screen in a
  # performant way.
  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ${mainUser} qemu-libvirtd -"
  ];

  # Add looking-glass-client with patch
  environment.systemPackages = with pkgs; [
    looking-glass-client
    # (looking-glass-client.overrideAttrs (oldAttrs: {
    #   postPatch = (oldAttrs.postPatch or "") + ''
    #     substituteInPlace displayservers/Wayland/input.c \
    #       --replace-fail "if (axis != WL_POINTER_AXIS_VERTICAL_SCROLL)" \
    #                      "if (axis != WL_POINTER_AXIS_VERTICAL_SCROLL && value != 0)"
    #   '';
    # }))
  ];

  # Enable virtualisation programs. These will be used by virt-manager to run your VM.
  virtualisation = {
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
