# More Openbox themes by addy-dclxvi
{ pkgs, stdenv, lib, ... }:

stdenv.mkDerivation {
  pname = "openbox-theme-collections";
  version = "1.0";
  src = pkgs.fetchgit {
    url = "https://github.com/addy-dclxvi/openbox-theme-collections.git";
    rev = "8bdf5decb25c9867d11011f386453380fc908121";
    hash = "sha256-aC6AA09S/NE74fFNQXK8R/AVA3w4JWKjhcgEkCtGGdk=";
  };

  dontBuild = true;

  installPhase = ''
    # create destination directory
    mkdir -p $out/share/themes/openbox-theme-collections/
    # and copy files
    cp -ar * $out/share/themes/openbox-theme-collections/
  '';

  meta = with lib; {
    description = "Openbox Theme collections by addy-dclxvi";
    longDescription = ''
      Personal collection of addy-dclxvi's Openbox themes.
      These are window decorators.
      Matching GTK themes are `Lumiere` (light) and `Fantome` (dark),
      available in custom package `gtk-theme-collections` by same author.
    '';
    homepage = "https://github.com/addy-dclxvi/openbox-theme-collections";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.jawuku ];
  };
}

