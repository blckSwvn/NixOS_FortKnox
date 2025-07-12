{ config, pkgs, lib, ... }: {

imports = [
./modules/zsh.nix
./modules/boot.nix
./modules/networking.nix
];

isoImage.isoName = "nixos";

nix.settings = {
auto-optimise-store = true;
};

programs.zsh.promptInit = lib.mkForce "";
programs.zoxide.enableZshIntegration = lib.mkForce false;
programs.zoxide.enable = lib.mkForce false;

boot = {
loader.grub.enable = lib.mkForce true;
initrd.kernelModules = lib.mkForce [];
blacklistedKernelModules = lib.mkForce [];
kernelModules = lib.mkForce [];
kernelParams = lib.mkForce [];
};

networking.wireless.enable = lib.mkForce false;
networking.hostName = lib.mkForce "";


# Set your time zone.
time.timeZone = "Europe/Oslo";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

# Configure console keymap
console.keyMap = "no";

environment.systemPackages = with pkgs; [
neovim
git
fzf
fd
tldr
];

services.keyd = {
  enable = true;
  keyboards.default = {
    ids = [ "*" ];
    settings = {
    main = {
      capslock = "esc";
      };
    };
  };
};

users.users.root = {
  initialPassword = "root";
  shell = pkgs.zsh;
};

environment.variables = {
MANPAGER = "nvim +Man!";
EDITOR = "nvim";
};

system.stateVersion = "25.05";

}
