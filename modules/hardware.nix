{ config, pkgs, ... } : {
#sound
hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  jack.enable = false;
  alsa.enable = true;
  alsa.support32Bit = false;
  pulse.enable = true; #enable for qemu/quickemu
};

#bloat
services = {
  printing.enable = false;
  avahi.enable = false;
  dbus.enable = true;
};


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

hardware.nvidia = {
#modsetting.enable = true; #dont work refuses to build
#powerManagment.enable = true;
package = config.boot.kernelPackages.nvidiaPackages.production;
nvidiaSettings = true;
open = false;
prime = {
  sync.enable = true;
  amdgpuBusId = "PCI:230:0:0";
  nvidiaBusId = "PCI:1:0:0";
  };
};
}
