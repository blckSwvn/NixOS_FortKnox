{ config, pkgs, ... }: {

imports = [
	# Include the results of the hardware scan.
	./hardware-configuration.nix
	./modules/boot.nix
	./modules/hardware.nix
	./modules/networking.nix
	./modules/packages.nix
	./modules/zsh.nix
	./modules/vmSpecial.nix
];

#nix settings
nix.settings = {
experimental-features = [ "nix-command" "flakes" ];
auto-optimise-store = true;
};


# Set your time zone.
time.timeZone = "Europe/Oslo";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";


# Configure console keymap
console.keyMap = "no";


#user
users.users.blckSwan = {
  isNormalUser = true;
  description = "null";
  shell = pkgs.zsh;
  extraGroups = [
  "kvm"
  "input"
  "qemu"
  ];
};
#openBSD replacment for sudo its safer less LOC 
security.doas = {
  enable = true;
  extraRules = [{
  users = ["blckSwan"];
  keepEnv = true;
  persist = false;
  }];
};

#disable sudo since doas
security.sudo.enable = false;

users.users.root = {
shell = pkgs.zsh;
};

services.logind.lidSwitch = "ignore";


environment.variables = {
MANPAGER = "nvim +Man!";
EDITOR = "nvim";
};

system.stateVersion = "25.05";
}
