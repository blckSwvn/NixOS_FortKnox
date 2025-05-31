{ config, pkgs, unstablePkgs, ... } : {

#packages
environment.systemPackages = with pkgs; [
  #term
  bat
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

programs.obs-studio = {
enable = false; #disabled, runs heavy background processes
plugins = with pkgs.obs-studio-plugins; [
obs-pipewire-audio-capture
 ];
};

programs.nix-ld.enable = true;

}
