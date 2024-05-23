# Installs Nord Openbox Theme by the-zero885
{ pkgs, stdenv, lib, ... }:

stdenv.mkDerivation {
  pname = "nord-openbox-theme";
  version = "1.0";
  src = pkgs.fetchgit {
    url = "https://gitlab.com/the-zero885/Nord-openbox-theme.git";
    rev = "1818f7a1ba4f397cceb9023f7e14b35201e597f1";
    hash = "sha256-oaZ+YZOCIUzetCYs0BVXzmbGn96qKiJcRS/kCi2nyQY=";
  };

  dontBuild = true;

  installPhase = ''
    # runHook preInstall
    mkdir -p $out/share/themes/nord-openbox-theme/
    cp -ar openbox-3/ $out/share/themes/nord-openbox-theme/
    # runHook postInstall
  '';

  meta = with lib; {
    description = "Openbox Nordic Theme by César Salazar";
    longDescription = "Nordic-style window decorations.\nThis theme can also complement the `nordic` Nix package";
    homepage = "https://gitlab.com/the-zero885/Nord-openbox-theme";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.jawuku ];
  };
}
