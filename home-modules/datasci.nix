# Data Science Languages Module
# Python 3.11 with packages, RStudio, Julia, Octave, MySQL
{ config, pkgs, ... }:

let
  # Python with packages
  my-python-packages = ps:
    with ps; [
      sympy
      seaborn
      scikit-learn
      gmpy2
      mpmath
      statsmodels
      requests
      pyyaml
      pycountry
      beautifulsoup4
      notebook # Jupyter
      /* Python Helix packages - using Ruff / Pyright instead
      python-lsp-server
      pyls-isort
      python-lsp-black
      pyls-flake8
      */
    ];
in
{
  # Home packages
  home.packages = with pkgs; let
    # R packages
    RStudio = rWrapper.override {
      packages = with rPackages; [
        tidyverse
        languageserver
      ];
    };
  in
  [
    (python311.withPackages my-python-packages)
    RStudio
    julia-bin
    octaveFull
    sequeler
  ];
}

