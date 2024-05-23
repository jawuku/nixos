# Git configuration
{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "jawuku";
    userEmail = "j.awuku@gmail.com";
    extraConfig = {
      core = {
        editor = "vim";
        autoclrf = "input";
      };
    };
  };
}
