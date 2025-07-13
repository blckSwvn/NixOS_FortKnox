{config, pkgs, unstablePkgs, ... }: {

specialisation.vm = {
  environment.systemPackages = with pkgs; [
    quickemu
    qemu_kvm
    spice-gtk
    virtiofsd
    pcieutils
  ];

  boot.kernelModules = [
    "kvm"
    "kvm_amd"
  ];
  boot.kernelParams = [
    "amd_iommu=on"
    "default_hugepagesz=1G"
    "hugepagesz=1G"
    "hugepages=8"
  ];
};

}
