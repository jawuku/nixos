# Git configuration
{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "jawuku";
    userEmail = "j.awuku@gmail.com";
    aliases = {
      cm = "commit";
      co = "checkout";
      s = "status";
    };
    extraConfig = {
      core = {
        editor = "vim";
        autoclrf = "input";
      };
    };
  };
}
