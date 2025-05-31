{ config, pkgs, ... } : {

#zsh
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  shellAliases = {
    ".." = "cd ..";
    vim = "nvim";
    vimf = "nvimf";
    fetch = "fastfetch";
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
