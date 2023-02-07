{ nixpkgs, lib, ... }:

nixpkgs.stdenv.mkDerivation rec {
  pname = "apple-cursor-theme";
  version = "2.0.0";

  src = nixpkgs.fetchzip {
    url = "https://github.com/ful1e5/apple_cursor/releases/download/v${version}/macOS-Monterey.tar.gz";
    sha256 = "sha256-MHmaZs56Q1NbjkecvfcG1zAW85BCZDn5kXmxqVzPc7M=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/apple-cursor-theme
    cp -r . $out/share/icons/apple-cursor-theme
  '';

  meta = with lib; {
    description = "Opensource macOS Cursors";
    homepage = "https://github.com/ful1e5/apple_cursor";
    license = licenses.gpl3;
    maintainers = [ maintainers.rapherion ];
    platforms = platforms.linux;
  };
}
