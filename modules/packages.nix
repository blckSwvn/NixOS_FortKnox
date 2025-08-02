{ config, pkgs, unstablePkgs, lib, ... } : {

#packages
environment.systemPackages = with pkgs; [
  #term
  starship
  bash
  wineWowPackages.full
  bat
  brightnessctl
  git
  btop
  fzf
  fd
  parted
  gnumake
  #progs
  quickemu
  modrinth-app
  blueberry
  librewolf
  #etc
  tldr
  #DE
  swaybg
  wofi
  playerctl
  wl-clipboard
  grim
  slurp
  #bloat
  fastfetch
  nitch
  #langs/lsps
  nixd
  clang-tools
  gcc
] ++ (with unstablePkgs; [
]);

fonts.packages = with pkgs; [
  nerd-fonts.meslo-lg
  jetbrains-mono
];

#fonts.packages = [ ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

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

programs.steam = {
 enable = true;
};

programs.obs-studio = {
enable = false; #disabled, runs heavy background processes
plugins = with pkgs.obs-studio-plugins; [
obs-pipewire-audio-capture
 ];
};

programs.nix-ld.enable = true;

}
