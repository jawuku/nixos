# Openbox configuration for Home Manager
# try this one to test out new user-defined function
# and conky
{ config, pkgs, lib, ... }:
let
  nord-openbox-theme = with import <nixpkgs> { }; callPackage ./openbox/nord-openbox-theme.nix { };
  openbox-debian-themes = with import <nixpkgs> { }; callPackage ./openbox/openbox-debian-themes.nix { };
in

{

  # Import some apps with their individual configurations
  imports = [
    ./openbox/polybar.nix
  # ./openbox/conky.nix
  ];

  # Packages for Openbox
  home.packages = with pkgs; [
    # Desktop apps
    geany # Text editor and basic IDE
    lxde.lxtask # Task and Process Manager
    kazam # Screen shots
    lxqt.lxqt-policykit # Sudo password for GUI apps
    mate.atril # PDF viewer
    lxappearance # Theme configurations
    obconf # Openbox configuration
    ulauncher # Application launcher
    gsimplecal # Mini calendar app
    abiword # Lightweight word processor
    feh # Wallpaper manager
    mate.engrampa # Archive manager
    transmission-gtk # Bittorrent downloader
    sakura # Lightweight terminal
    plank # Application launcher at the bottom
    bamf # library for plank
    pavucontrol # volume control
    jgmenu # menumaker # Simple Openbox menu generator
    libnotify # enables to display notifications
    smplayer mpv # media player
    viewnior # picture viewer

    # Themes e.g. icons, GTK etc.
    gnome.adwaita-icon-theme
    yaru-theme
    tela-circle-icon-theme
    qogir-icon-theme
    hicolor-icon-theme
    arc-theme
    nordic

    # Custom Openbox packages via derivations (see imports above)
    nord-openbox-theme
    openbox-debian-themes
  ];

  # Picom compositor
  services.picom = {
    enable = true;
    fade = true;
    backend = "glx";
  };

  # Redshift screen colour temperature
  services.redshift = {
    enable = true;
    tray = true;
    # coordinates for Trafalgar Square, London
    latitude = 51.05;
    longitude = -0.128;
    # set colour temperature between day and night
    temperature = {
      day = 5500;
      night = 3500;
    };
  };

  # Dunst screen notification
  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
      size = "24x24";
    };
    settings = {
      global = {
        monitor = 0;
        geometry = "600x50-50+65";
        shrink = "yes";
        transparency = 10;
        padding = 16;
        horizontal_padding = 16;
        font = "Noto Sans 12";
        line_height = 4;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
        sort = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        icon_position = "left";
        max_icon_size = 32;
      };
    };
  };

  # define Openbox autostart file
  home.file.".config/openbox/autostart".text = ''
    # xrandr -s 1920x1080
    ulauncher --no-window &
    lxqt-policykit-agent &
    plank &
    polybar &
    feh --recursive --randomize --bg-fill /home/jason/Pictures/Wallpapers &
    xidlehook --timer 600 --not-when-fullscreen &
    # mmaker Openbox3 -f -t sakura &
  '';

  # Openbox main configuration file
  home.file.".config/openbox/rc.xml".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/jawuku/dotfiles/master/.config/openbox/rc.xml";
    sha256 = lib.fakeHash; # Remember to replace with true hash when building.
  }; 
}
