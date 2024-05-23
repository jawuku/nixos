# Kitty Terminal Emulator
{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Gruvbox Material Light Medium";
    settings = {
      font_size = "16.0";
      font_family = "RobotoMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      disable_ligatures = true;
      # font_features = "+ss02 +ss08 +cv16 +ss05";
      scrollback_lines = 10000;
      enable_audio_bell = false;
      remember_window_size = true;
      initial_window_width = "87c";
      initial_window_height = "25c";
    };
  };
}
