# Bash shell configuration for Home Manager
{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "eza";
      ll = "eza -la --icons";
      lt = "eza --tree --icons";
      cat = "bat";
      rebuild = "sudo nixos-rebuild boot";
      trash-old = "sudo nix-collect-garbage -d";
      update = "sudo nix-channel --update";
      upgrade = "sudo nixos-rebuild boot --upgrade";
      nixconfig = "sudo hx /etc/nixos/";
    };
    sessionVariables = {
      EDITOR = "hx";
      BAT_THEME = "Visual Studio Dark+";
    };
  };
}
