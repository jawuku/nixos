# Openbox Debian themes missing from default Nix Openbox installation
{ pkgs, stdenv, lib, ... }:

stdenv.mkDerivation {
  name = "openbox-debian-themes";
  version = "3.6.1";
  src = pkgs.fetchgit {
    url = "https://github.com/mati75/openbox-debian";
    sparseCheckout = [
      "debian/themes/"
    ];
    rev = "cdca8d5076420bbb6377aa40d59455394fb8a5a8";
    hash = "sha256-W1ZH+vtxOKsptGSVNjezTPHPE/7hSb4TB098viKpK5c=";
  };

  dontConfigure = true;

  installPhase = ''
    # runHook preInstall
    mkdir -p $out/share/themes/
    cd $src/debian/
    cp -ar themes/ $out/share/
    # runHook postInstall
  '';

  meta = with lib; {
    description = "5 Openbox themes from Debian";
    longDescription = ''
      These 5 themes are included in the default Debian Openbox,
      but are absent in the NixOS Openbox installation, because
      Nix uses the upstream Openbox source code, which does not
      have these themes.

      **List of Themes**
      `Breeze` KDE-style decoration
      `Nightmare` (Black decoration with red accent colour)
      `Nightmare-01` (Red decoration with red accent colour)
      `Nightmare-02` (Blue decoration with blue accent colour)
      `Nightmare-03` (Green decoration with green accent colour)

      Original developer of Nightmare themes:
      MAXIM2 at https://www.ping.com/p/1017737/

      Original developer of Breeze Openbox theme:
      jcsl at https://www.pling.com/p/1017288/
    '';
    homepage = "https://github.com/mati75/openbox-debian";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    maintainers = [ maintainers.jawuku ];
  };
}
