{ config, pkgs, unstablePkgs, ... } : {

imports = [
  ./home/sway/sway.nix
  ./home/nvim/nvim.nix
  ./home/alacritty/alacritty.nix
  ./home/wofi/wofi.nix
  ./home/waybar/waybar.nix
  ./home/starship/starship.nix
];

home.username = "null";
home.homeDirectory = "/home/null";

home.stateVersion = "25.05";

programs.home-manager.enable = true;
}
