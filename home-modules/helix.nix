# Helix text editor module
{ config, pkgs, ... }:
let
  # Add unstable channel to install a few packages - type following 2 commands:
  # sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # sudo nix-channel --update
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in

{
  programs.helix = {
    enable = true;
    # use version from `unstable` channel for latest features
    package = unstable.helix;

    # Generate ~/.config/helix/config.toml
    settings = {
      # default theme, `gruvbox_light_soft` theme selectable too
      theme = "dark_plus";

      editor = {
        line-number = "relative";
        mouse = true;
        auto-format = true;
        bufferline = "multiple";
        auto-pairs = true;
        cursorline = true;
        true-color = true;
        soft-wrap.enable = true;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "┊"; # Unicode character 0x250A
          skip-levels = 1;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "read-only-indicator"
            "file-modification-indicator"
          ];

          center = [ "file-name" ];

          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];

          separator = "│"; # Unicode character 0x2502

          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };

        lsp = { display-messages = true; };
      };

      # key mappings
      keys = {
        normal = {
          esc = [ "collapse_selection" "keep_primary_selection" ];

          # Space-t-d selects Dark+ Theme (Default)
          space.t.d = ":theme dark_plus";

          # Space-t-l selects Gruvbox Light Theme
          space.t.l = ":theme gruvbox_light_soft";
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = { command = "nixpkgs-fmt"; };
        }

        {
          name = "python";
          language-servers = [ "pyright" ];
          formatter = { command = "black";
                        args = ["--quiet" "-" ];
                      };
        }

        {
          name = "markdown";
          language-servers = [ "marksman" "ltex-ls" ];
        }
      ];
    };
  };
}

