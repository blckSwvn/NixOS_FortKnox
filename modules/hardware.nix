{ config, pkgs, ... } : {
#sound
hardware.pulseaudio.enable = false;
security.rtkit.enable = false;
services.pipewire = {
  enable = true;
  jack.enable = false;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true; #enable for qemu/quickemu
};

#bloat
services = {
  printing.enable = false;
  avahi.enable = false;
  dbus.enable = true;
  acpid.enable = false;
  xserver.enable = false;
};

security.polkit.enable = false;


hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
};


hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

#cpu optimization
services.tlp = {
  enable = true;
  settings = {
    CPU_SCALING_GOVERN_ON_AC = "performance";
    CPU_SCALING_GOVERN_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
    TLP_DEFAULT_MODE = "BAT";
    TLP_PERSISTENT_DEFAULT = 1;
    };
  };

services.xserver.videoDrivers = [ "nvidia" ];

hardware.nvidia.modesetting.enable = true;
hardware.nvidia.powerManagement.enable = true;

hardware.nvidia = {
package = config.boot.kernelPackages.nvidiaPackages.beta; #prod aka latest aka stable usally
nvidiaSettings = true;
open = false;
prime = {
  sync.enable = true;
  intelBusId = "PCI:230:0:0";
  nvidiaBusId = "PCI:1:0:0";
  };
};
}
