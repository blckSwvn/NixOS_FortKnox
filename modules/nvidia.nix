{ config, pkgs, ... }: {

  boot.initrd.kernelModules = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "noveau" ];

  boot.kernelModules = [ "nvidia" ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.powerManagement.enable = true;


  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    open = false;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:230:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  programs.steam.package = pkgs.steam.override {
    withPrimus = true;
  };
                            }
