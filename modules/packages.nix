{ config, pkgs, unstablePkgs, lib, ... } : {

#packages
  environment.systemPackages = with pkgs; [
#term
    starship
      quickemu
      bash
      wineWowPackages.full
      bat
      brightnessctl
      git
      btop
      fzf
      ripgrep
      fd
      parted
      gnumake
#progs
      modrinth-app
      obsidian
      blueberry
      librewolf
      mullvad-browser
#etc
      tldr
#DE
      xwayland
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
      lua-language-server
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

  programs.obs-studio = {
    enable = false; #disabled, runs heavy background processes
      plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      ];
  };

  programs.nix-ld.enable = true;

                                           }
