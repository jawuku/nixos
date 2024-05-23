# GTK themes by addy-dclxvi
{ pkgs, stdenv, lib, ... }:

stdenv.mkDerivation {
  pname = "gtk-theme-collections";
  version = "1.0";
  src = pkgs.fetchgit {
    url = "https://github.com/addy-dclxvi/gtk-theme-collections.git";
    rev = "653687130a549a402528501f148db58a66a3ef7c";
    hash = "sha256-iysMQSwN23iPbcswZkX+oxi7KM2BDuEfd3l0PFxeD3U=";
  };

  dontBuild = true;

  installPhase = ''
    # create destination directory
    mkdir -p $out/share/themes/gtk-theme-collections/

    # remove `Bonus` directory
    rm -rf Bonus/

    # then copy everything
    cp -ar * $out/share/themes/gtk-theme-collections/
  '';

  meta = with lib; {
    description = "GTK Theme collections by addy-dclxvi";
    longDescription = ''
      Personal collection of addy-dclxvi's GTK themes.
      These are for GTK 2 and 3.
      `Lumiere` (light) and `Fantome` (dark), match Openbox themes.
      `Bonus` directory 
    '';
    homepage = "https://github.com/addy-dclxvi/gtk-theme-collections";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.jawuku ];
  };
}

