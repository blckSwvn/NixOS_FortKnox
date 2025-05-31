{ config, pkgs, unstablePkgs, ... } : {

#packages
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
  gnumake
  #progs
  librewolf
  #etc
  tldr
  #DE
  i3
  wofi
  playerctl
  wl-clipboard
  grim
  slurp
  #bloat
  fastfetch
  #langs/lsps
  nil
  clang-tools
] ++ (with unstablePkgs; [
  #unstable pkgs here
]);


fonts.packages = with pkgs; [
  nerd-fonts.meslo-lg
  jetbrains-mono
];


programs.sway.enable = true;

programs.obs-studio = {
enable = false; #disabled, runs heavy background processes
plugins = with pkgs.obs-studio-plugins; [
obs-pipewire-audio-capture
 ];
};

programs.nix-ld.enable = true;

}
