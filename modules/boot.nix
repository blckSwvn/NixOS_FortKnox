{ config, pkgs, unstablePkgs, ... } : {
  boot = {
#bootloader
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
#useOSProber = true if you use multable oses
        useOSProber = false;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "nvidia" ];
    blacklistedKernelModules = [ "nouveau" ];

    supportedFilesystems = [
      "ntfs"
#"exfat"
    ];

    kernelPackages = pkgs.linuxPackages_6_16;

    kernelModules = [
      "kvm"
        "kvm_amd"
        "nvidia"
#"exfat" 
    ];
    kernelParams = [
      "amd_iommu=on"
        "block.mq=on"
        "nowatchdog"
        "loglevel=3" #only errors and beyond are logged change how needed 4:warning 5:notice 6:info 7:debug
        "amd_pstate=active" #better for newer CPUs
    ];

#hardned kernel
    kernel.sysctl = {
      "kernel.yama.ptrace_scope" = 2;  # restrict ptrace
        "net.ipv4.tcp_syncookies" = 1;   # protect from SYN flood
        "net.ipv4.tcp_rfc1337" = 1;      # disable TIME-WAIT assassination
        "net.ipv4.conf.all.log_martians" = 1;  # log suspicious packets
        "net.ipv4.conf.default.log_martians" = 1;
      "kernel.kexec_load_disabled" = 1; # disable kexec to prevent kernel replacement
        "kernel.unprivileged_userns_clone" = 1; #no unprivleged namespace creation #steam needs it at 1 to work
        "kernel.kptr_restrict" = 2; #no acess to kernel pointers
        "kernel.dmesg_restrict" = 1; #normal users no see dmesg log
        "kernel.randomize_va_space" = 2; # Full ASLR adress space layour randomization
        "fs.protected_hardlinks" = 1; #protected hardlinks less privlage escalation
        "fs.protected_symlinks" = 1; #protected symlinks
        "fs.suid_dumpable" = 0; #no core dumps from SUID progs
        "net.ipv4.conf.all.rp_filter" = 1; #drop spoofed packets that don't make routing sense
        "net.ipv4.conf.all.accept_source_route" = 0; #disable source routing largely not needed on modern hardware
        "net.ipv4.conf.default.log.martians" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;   #same but for future interfaces
        "net.ipv4.icmp_echo_ignore_broadcasts" = 1;   #ignore broadcast pings, stops smurf attack bs
        "net.ipv4.conf.all.accept_redirects" = 0;   #no accepting icmp redirects, blocks mitm tricks
        "net.ipv4.conf.default.accept_redirects" = 0;   #same for new interfaces
        "net.ipv4.conf.all.send_redirects" = 0;   #dont send icmp redirects either, we're not a router
        "net.ipv4.conf.default.send_redirects" = 0;   #same but default
        "vm.swappiness" = 10; #the % left threshold for when it writes to disk rather than ram
    };
  };

  security.protectKernelImage = true;

#if set to true will preven network module from loading
  security.lockKernelModules = false;
                                      }
