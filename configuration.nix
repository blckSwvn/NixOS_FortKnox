{ config, pkgs, unstablePkgs, ... }: {

imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];


#nix settings
nix.settings = {
experimental-features = [ "nix-command" "flakes" ];
auto-optimise-store = true;
};

#boot, kernel
boot = {
  #bootloader
  loader.systemd-boot.enable = true;
  loader.efi.canTouchEfiVariables = true;
  
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


#networking
networking = {
hostName = "nixos"; # Define your hostname.
networkmanager.enable = true;
firewall = {
  enable = true;
  allowedTCPPorts = [
    #3478  #TDP
    80    #HTTP
    443   #HTTPS
    51820 #WireGuard
    #22    #SSH
    #53    #DNS
    ];
  };
};

#Fail2ban
services.fail2ban = {
  enable = true;
  maxretry = 5;
  ignoreIP = [
  ];
  bantime = "24h";
  bantime-increment = {
    enable = true; # Enable increment of bantime after each violation
    formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
    maxtime = "168h";
    overalljails = true; # Calculate the bantime based on all the violations
  };
};

#SSH
services.openssh = {
  enable = false;
  passwordAuthentication = false;
  useDns = true;
  permitRootLogin = "no";
};


# Set your time zone.
time.timeZone = "Europe/Oslo";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";


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


# Configure console keymap
console.keyMap = "no";


#user
users.users.null = {
  isNormalUser = true;
  description = "null";
  shell = pkgs.zsh;
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [];
};


#packages
#nixpkgs.config.allowUnfree = true;
environment.systemPackages = with pkgs; [
  #term
  bat
  alacritty
  neovim
  git
  btop
  fzf
  fd
  parted
  #progs
  librewolf
  #etc
  tldr
  #DE
  playerctl
  wl-clipboard
  grim
  slurp
  #bloat
  fastfetch
  #langs/lsps
  nil
] ++ (with unstablePkgs; [
  #unstable pkgs here
]);



#zsh
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  shellAliases = {
    ".." = "cd ..";
    vim = "nvim";
    vimf = "nvimf";
    fetch = "fastfetch";
  };
  shellInit = ''

    cdf() {
      selected=$(fd --hidden --exclude .git | fzf --preview "ls -l {}" --border)
      if [ -d "$selected" ]; then
        cd "$selected" || echo "Directory $selected not found"
      elif [ -f "$selected" ]; then
        nvim "$selected" || echo "File $selected not found"
      else
        echo "$selected is neither a file nor a directory"
      fi
    }
  nvimf() { nvim "$(fd --hidden --exclude .git | fzf)" }
  fehf()  { feh "$(fd --type f --exclude .git | fzf )" }

  export FZF_DEFAULT_OPTS="--height 100% --border --preview 'bat --style=numbers --color=always --line-range=:500 {}' --preview-window=right:60%"
  export fzf_default_command='fd --type f --hidden --exclude .git'
  export fzf_ctrl_t_command="$fzf_default_command"
  '';
};

fonts.packages = with pkgs; [
  nerd-fonts.meslo-lg
  jetbrains-mono
];

programs.sway.enable = true;

#obs
programs.obs-studio = {
enable = false; #disabled, runs heavy background processes
plugins = with pkgs.obs-studio-plugins; [
obs-pipewire-audio-capture
 ];
};

programs.nix-ld.enable = true;

environment.variables = {
MANPAGER = "nvim +Man!";
EDITOR = "nvim";
};

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "25.05"; # Did you read the comment?
}
