{ config, pkgs, ... }: {
  services.xserver.videoDrivers = ["noveau"];
  boot.blacklistedKernelModules = [ "nvidia" "nvidia_drm" "nvidia_modeset" ];
                            }
