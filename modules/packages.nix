{ config, pkgs, unstablePkgs, ... } : {

#packages
environment.systemPackages = with pkgs; [
  #term
  starship
  bash
  unrar
  wineWowPackages.full
  networkmanagerapplet
  bat
  brightnessctl
  neovim
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
  rivercarro
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
  nil
  clang-tools
  gcc
] ++ (with unstablePkgs; [
]);

fonts.packages = with pkgs; [
  nerd-fonts.meslo-lg
  jetbrains-mono
];

#xdg.portal = {
#enable = true;
#wlr.enable = true;
#extraPortals = [pkgs.xdg-desktop-portal-gtk ];
#};

programs.steam = {
 enable = true;
};

programs.hyprland = {
enable = true;
xwayland.enable = true;
};

programs.obs-studio = {
enable = false; #disabled, runs heavy background processes
plugins = with pkgs.obs-studio-plugins; [
obs-pipewire-audio-capture
 ];
};

programs.nix-ld.enable = true;

}
