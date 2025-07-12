# NixOS FortKnox

### Short Description  
Personal NixOS configuration for my laptop.  
Aims for safety, performance, productivity, and ease of maintenance and use.

**Highlights:**  
- Uses flakes  
- Home Manager integration  
- Modular configuration  
- Nvidia Prime Sync drivers
- zsh with aliases, starship, fzf, zoxide and customized to my workflow

---

## Prerequisites  
1. NixOS machine with flakes enabled  
2. Git installed

---

## Installation  

### Recommended (git clone)  
```bash
cd /home/null
git clone https://github.com/AwfullyBlank/NixOS_FortKnox.git
cd NixOS_FortKnox
sudo nixos-rebuild switch --flake .#Cyclops
```
## Alternative (no cloning)
```bash
sudo nixos-rebuild switch --flake github:AwfullyBlank/NixOS_FortKnox#main
```
**Note:** to make any changes now or later, cloning the repo(recommended method) is necessary.

## making and burning ISO

### making
```bash
nix build #nixosConfigurations.iso.config.system.build.isoImage
```

### burning
```bash
sudo dd if=./result/iso/nixos-minimal-25.05.20250602.10d7f8d-x86_64-linux.iso of=/dev/sdb bs=16M status=progress oflag=sync
```
