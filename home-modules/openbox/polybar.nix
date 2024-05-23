# Polybar config
# inspired by Gabriel Volpe's blog : "XMonad + Polybar on NixOS"
# https://gvolpe.com/blog/xmonad-polybar-nixos/
{ config, pkgs, ... }:

let
  custom-polybar = pkgs.polybar.override {
    pulseSupport = true;
  };
in

{
  services.polybar = {
    enable = true;
    package = custom-polybar;
    settings = rec {
      "colors" = {
        background.text = "#282A2E";
        background.alt = "#373B41";
        foreground = "#C5C8C6";
        primary = "#F0C674";
        secondary = "#8ABEB7";
        alert = "#A54242";
        disabled = "#707880";
      };

      "bar/example" = {
        width = "100%";
        height = "24pt";
        radius = "6";

        background = colors.background;
        foreground = colors.foreground;

        line.size = "3pt";

        border.size = "4pt";
        border.color = "#00000000";

        padding.left = "0";
        padding.right = "1";

        module.margin = "1";

        separator.text = "|";
        separator.foreground = colors.disabled;

        font = [ "monospace;2" ];

        modules.left = "jgmenu xworkspaces xwindow";
        modules.right = "filesystem pulseaudio xkeyboard memory cpu wlan eth date";

        cursor.click = "pointer";
        cursor.scroll = "ns-resize";

        enable.ipc = true;
      };

      "module/systray" = {
        type = "internal/tray";

        format.margin = "8pt";
        tray.spacing = "16pt";
      };

      "module/jgmenu" = {
        type = "custom/text";
        content.padding = "2";
        context = "menu";
        format.prefix.text = "\"jgmenu\"";
        format.prefix.foreground = colors.primary;
        click.left  = "jgmenu_run >/dev/null 2>&1 &";
        click.right = "jgmenu_run >/dev/null 2>&1 &";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";

        label.active.text = "%name%";
        label.active.background = colors.background;
        label.active.underline = colors.primary;
        label.active.padding = "1";

        label.occupied.text = "%name%";
        label.occupied.padding = "1";

        label.urgent.text = "%name%";
        label.urgent.background = colors.alert;
        label.urgent.padding = "1";

        label.empty.text = "%name%";
        label.empty.foreground = colors.disabled;
        label.empty.padding = "1";
      };

      "module/xwindow" = {
        type = "internal/xwindow";
        label = "%title:0:60:...%";
      };

      "module/filesystem" = {
        type = "internal/fs";
        interval = "25";

        mount = [ "/" ];

        label.mounted = "%{F#F0C674}%mountpoint%%{F-} %percentage_used%%";

        label.unmounted.text = "%mountpoint% not mounted";
        label.unmounted.foreground = colors.disabled;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";

        format.volume.text = "<label-volume>";
        format.volume.prefix.text = "VOL ";
        format.volume.prefix.foreground = colors.primary;
        label.muted.text = "muted";
        label.muted.foreground = colors.disabled;
        label.volume = "%percentage%%";
        click.right = "pavucontrol &";
      };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist = [ "num lock" ];

        label.layout.text = "%layout%";
        label.layout.foreground = colors.primary;

        label.indicator.padding = "2";
        label.indicator.margin = "1";
        label.indicator.foreground = colors.background;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = "2";
        format.prefix.text = "\"RAM \"";
        format.prefix.foreground = colors.primary;
        label = "%percentage_used:2%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = "2";
        format.prefix.text = "\"CPU \"";
        format.prefix.foreground = colors.primary;
        label = "%percentage:2%%";
      };

      "network-base" = {
        type = "internal/network";
        interval = "5";
        format.connected = "<label-connected>";
        format.disconnected = "<label-disconnected>";
        label-disconnected = "%{F#F0C674}%ifname%%{F#707880} disconnected";
      };

      "module/wlan" = {
        inherit "network-base";
        interface.type = "wireless";
        label.connected = "%{F#F0C674}%ifname%%{F-} %essid%";
      };

      "module/date" = {
        type = "internal/date";
        interval = "1";
        date.text = "%H:%M";
        date.alt = "%A, %d %B %Y = %H:%M:%S";

        label.text = "%date%";
        label.foreground = colors.primary;
        click.right = "gsimplecal &";
      };

      "settings" = {
        screenchange.reload = true;
        pseudo.transparency = true;
      };
    };

    script = ''
      polybar &
    '';
  };
}
