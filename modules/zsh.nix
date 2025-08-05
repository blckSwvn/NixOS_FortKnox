{ config, pkgs, ... } : {

#zsh
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init zsh)"

    if [[ -z "$ZSH_LOGGED_IN" && $- == *l* ]]; then
      export ZSH_LOGGED_IN=true
      echo -e "\033[1;34m
        ┌────────────────────────────────────────────┐
        │ Welcome aboard captain, all systems online │
	└────────────────────────────────────────────┘
        \033[0m"
    fi
  '';
  shellAliases = {
    ".." = "cd ..";
    "~" = "cd ~";
    nixshell = "nix-shell --run zsh";
    v = "nvim";
    vf = "nvimf";
    rebuild = "doas env GIT_ALLOW_ROOT=1 nixos-rebuild switch --flake path:/home/blckSwan/NixOS_FortKnox#Cyclops";
    fetch = "fastfetch";
    gc = "git commit";
    gp = "git push origin main";
    gs = "git status";
    sudo = "doas";
  };
  shellInit = ''

    cdf() {
      selected=$(fd --hidden --exclude .git | fzf --preview "ls -l {}" --border)
      if [ -d "$selected" ]; then
        cd "$selected" || echo "Directory $selected not found"
      elif [ -f "$selected" ]; then
        nvim "$selected" || echo "File $selected not found"
      else
        echo "$selected is neither a file nor a directory"
      fi
    }

  nvimf() { nvim "$(fd --hidden --exclude .git | fzf)" }
  fehf()  { feh "$(fd --type f --exclude .git | fzf )" }

  export FZF_DEFAULT_OPTS="--height 100% --border --preview 'bat --style=numbers --color=always --line-range=:500 {}' --preview-window=right:60%"
  export fzf_default_command='fd --type f --hidden --exclude .git'
  export fzf_ctrl_t_command="$fzf_default_command"
  '';
};

}
