# Language Servers, Linters & Formatters
{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    ([
      # Nix Language Server
      nil
      nixpkgs-fmt

      # For SQL
      sleek

      # For JVM languages
      clojure-lsp
      clj-kondo
      (metals.override { jre = pkgs.jdk; })

      # Supplemental markdown language server to `marksman`
      ltex-ls
    ])

    # nodejs packages
    ++ (with pkgs.nodePackages; [
      bash-language-server
    ]);

  # Enable sqls language server
  programs.sqls.enable = true;
}

