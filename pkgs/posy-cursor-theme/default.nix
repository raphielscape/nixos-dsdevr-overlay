{ lib, stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pname = "posy-cursor-theme";
  version = "1.4";

  src = fetchzip {
    url = "https://github.com/simtrami/posy-improved-cursor-linux/archive/refs/tags/${version}.tar.gz";
    sha256 = "sha256-EvIoUq5g6+NynSPEylTj8tDUFEitGjxDw7CrhEgOlV8=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/posy-cursor-theme
    cp -r "." $out/share/icons/posy-cursor-theme
  '';

  meta = with lib; {
    description = "Posy's Cursor Improved for Linux";
    homepage = "https://github.com/simtrami/posy-improved-cursor-linux";
    license = licenses.gpl3;
    maintainers = [ maintainers.rapherion ];
    platforms = platforms.linux;
  };
}
