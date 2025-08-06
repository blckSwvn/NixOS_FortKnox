{config, pkgs, unstablePkgs, ... }: {

specialisation.vm.configuration = {
  environment.systemPackages = with pkgs; [
    quickemu
    qemu_kvm
    spice-gtk
    virtiofsd
  ];

services.udev.extraRules = ''
	ACTION=="add", KERNEL=="nvme1n1", GROUP="qemu", MODE="0660"
'';

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
