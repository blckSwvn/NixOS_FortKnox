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
#etc
      cowsay
      fortune
      torsocks
      brightnessctl
      tldr
      man-pages
      man-pages-posix
#DE
      xwayland
      waylock
      swaybg
      wofi
      playerctl
      wl-clipboard
      grim
      slurp
#langs/lsps
      clang-tools
      lua-language-server
      nixd
      vscode-langservers-extracted
      gcc
#VMs
      qemu
      quickemu
      qemu_kvm
      spice-gtk
      ] ++ (with unstablePkgs; [
      ]);

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.meslo-lg

#for less uniqueness
      # liberation_ttf #times new roman, arial, courier new
      # dejavu_fonts        # Very common Linux fonts
      # noto-fonts          # Covers many scripts, common
      corefonts           # Windows core fonts like Segoe UI
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
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = false;
  };

  programs.steam.gamescopeSession.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  #for dynamic linking
  programs.nix-ld.enable = true;

                                           }
