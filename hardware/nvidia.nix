{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
  cfg = config.hardware.nvidia;
  nvidiaPackage = config.boot.kernelPackages.nvidiaPackages.latest;
in
{
  options.hardware.nvidia = {
    enable = mkEnableOption "nvidia drivers";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.nvidia.acceptLicense = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    environment.systemPackages = with pkgs; [
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
        open = false;
      };
      opengl.enable = true;
      graphics = {
        enable = true;
        #driSupport = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          nvidia-vaapi-driver
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
  };
}
