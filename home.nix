# Configuration for Home-Manager
{ config, pkgs, lib, ... }:
let
  # Add unstable channel to install a few packages - type following 2 commands:
  # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # sudo nix-channel --update
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in

{
  # Import Modules into Home Manager
  imports = [
    ./home-modules/bash.nix
    ./home-modules/openbox2.nix
    ./home-modules/kitty.nix
    ./home-modules/helix.nix
    ./home-modules/datasci.nix
    ./home-modules/jvm-languages.nix
    ./home-modules/language-servers.nix
  ];

  # Home Packages
  home.packages = (with pkgs; [
    # Command line apps
    bat
    eza
    fastfetch
    cpufetch
    xclip
    epiphany
  ])

  # More up-to-date packages from unstable branch
  ++ (with unstable; [
    marksman
    ruff
    ruff-lsp
    yt-dlp
  ]);

  # Create User Directories e.g. Documents, Downloads etc.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # Network settings for Virt-Manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  home.stateVersion = "23.11";
}
