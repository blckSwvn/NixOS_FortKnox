{ config, pkgs, ... }: {

imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/packages.nix
    ./modules/zsh.nix
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
users.users.null = {
  isNormalUser = true;
  description = "null";
  shell = pkgs.zsh;
  extraGroups = [ "networkmanager" "wheel" ];
  packages = with pkgs; [];
};

services.logind.lidSwitch = "ignore";


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
