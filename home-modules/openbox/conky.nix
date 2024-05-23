# Conky configuration adapted from Cruchbang++ configuration
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ conky ];

  home.file = {
    ".config/conky/.conkyrc" = {
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/jawuku/dotfiles/master/.conkyrc";
        sha256 = "b7e3cd50408dc40508f9052ce3ace6321aad30bd003f54a5f3f4bdda1a3c077e";
      };
    };
  };
}
