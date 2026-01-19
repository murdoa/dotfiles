{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.hardware.nvidia;
  nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  options.hardware.nvidia = {
    enable = mkEnableOption "nvidia drivers";
  };

  config = mkIf cfg.enable {

    boot.kernelParams = [ "nvidia_drm.fbdev=0" ];

    nixpkgs.config.nvidia.acceptLicense = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    environment.systemPackages = with pkgs; [
      pciutils
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true; # Disable if issues with sleep/suspend
        package = nvidiaPackage;
        nvidiaSettings = true;
        open = true;
      };
      graphics = {
        enable = true;
        #driSupport = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
    };
  };
}
