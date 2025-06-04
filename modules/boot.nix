{ config, pkgs, unstablePkgs, ... } : {
boot = {
  #bootloader
  loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      gfxmodeEfi = "1920x1080";
      theme = ./grub-themes/CRT-Amber-GRUB-Theme/theme.txt;
    };
    efi.canTouchEfiVariables = true;
  };

  supportedFilesystems = [
    "ntfs"
    "exfat"
  ];
  
  kernelPackages = unstablePkgs.linuxPackages_latest;
  kernelModules = [
    "nvidia"
    "exfat" 
    "vfio"
  ];
  kernelParams = [
  "nohz_full=all"
  "block.mq"
  ];

  #hardned kernel
  kernel.sysctl = {
    "kernel.unprivileged_userns_clone" = 0; #no unprivleged namespace creation
    "kernel.kptr_restrict" = 2; #no acess to kernel pointers
    "kernel.dmesg_restrict" = 1; #normal users no see dmesg log
    "kernel.randomize_va_space" = 2; # Full ASLR adress space layour randomization
    "fs.protected_hardlinks" = 1; #protected hardlinks less privlage escalation
    "fs.protected_symlinks" = 1; #protected symlinks
    "fs.suid_dumpable" = 0; #no core dumps from SUID progs
    "net.ipv4.conf.all.rp_filter" = 1; #drop spoofed packets that don't make routing sense
    "net.ipv4.conf.default.rp_filter" = 1;   #same but for future interfaces
    "net.ipv4.icmp_echo_ignore_broadcasts" = 1;   #ignore broadcast pings, stops smurf attack bs
    "net.ipv4.conf.all.accept_redirects" = 0;   #no accepting icmp redirects, blocks mitm tricks
    "net.ipv4.conf.default.accept_redirects" = 0;   #same for new interfaces
    "net.ipv4.conf.all.send_redirects" = 0;   #dont send icmp redirects either, we're not a router
    "net.ipv4.conf.default.send_redirects" = 0;   #same but default
    "vm.swappiness" = 10;
  };
};

  #if enabled breaks networkmanager keep disabled
  security.protectKernelImage = false;
  security.lockKernelModules = false;
}
