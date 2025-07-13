{config, pkgs, unstablePkgs, ... }: {

specialisation.vm.configuration = {
  environment.systemPackages = with pkgs; [
    quickemu
    qemu_kvm
    spice-gtk
    virtiofsd
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
