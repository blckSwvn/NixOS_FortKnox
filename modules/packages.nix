{ config, pkgs, unstablePkgs, lib, ... } : {

#packages
  environment.systemPackages = with pkgs; [
#term
      starship
      quickemu
      bash
      bat
      git
      btop
      fzf
      ripgrep
      fd
      parted
      gnumake
#progs
      # modrinth-app
      wineWowPackages.full
      obsidian
#etc
      torsocks
      brightnessctl
      tldr
      man-pages
      man-pages-posix
#DE
      xwayland
      modrinth-app-unwrapped
      swaybg
      wofi
      playerctl
      wl-clipboard
      grim
      slurp
#langs/lsps
      vscode-langservers-extracted
      nix-init
      clang-tools
      gcc
#VMs
      qemu
      quickemu
      qemu_kvm
      spice-gtk
      virtio-win
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

  #for dynamic linking
  programs.nix-ld.enable = true;

                                           }
