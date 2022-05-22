{ lib, fetchFromGitHub, rustPlatform, freetype, ... }:

rustPlatform.buildRustPackage rec {
  pname = "figma-font-helper";
  version = "0.1.6";

  src = fetchFromGitHub {
    rev = "49efd1a37ea690378e88278c2a744dcf66210b23";
    owner = "Figma-Linux";
    repo = "figma-linux-font-helper";
    sha256 = "sha256-U66UPuNpbGqmrTlYSK+pGfejTaly3VIyIazghu/Xvco=";
  };

  patches = [ ./log.patch ];

  cargoSha256 = "sha256-AzcI92D/rUmmE5dJRtYtnrOVBZh5UhkN3/f8dUW5h5c=";

  buildInputs = [ freetype ];

  postInstall = ''
    mv $out/bin/font_helper $out/bin/fonthelper
  '';

  meta = with lib; {
    homepage = "https://github.com/Figma-Linux/figma-linux-font-helper";
    description = "Font Helper for Figma for Linux x64 platform";
    license = licenses.gpl2;
    platforms = platforms.linux;
    maintainers = [ maintainers.rapherion ];
  };
}
