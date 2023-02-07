{ lib
, fetchFromGitHub
, rustPlatform
, freetype
, fontconfig
, pkg-config
, llvmPackages_12
, ...
}:

rustPlatform.buildRustPackage rec {
  pname = "figma-agent-linux";
  version = "0.1.0";

  src = fetchFromGitHub {
    rev = "5b0afade2f5bb005f2827d92c43022153afeafe1";
    owner = "neetly";
    repo = "figma-agent-linux";
    sha256 = "sha256-yHWpgrgpTG5jkDItNXlLfkiPITpKjpPiu7mHZcTH4+Q=";
  };

  cargoSha256 = "sha256-AxTiCUq13z/P6eNy/Wr3rku95APJwLFwncEQrZqJYFQ=";

  nativeBuildInputs = [
    pkg-config
    llvmPackages_12.libclang.lib
    llvmPackages_12.clang
  ];
  buildInputs = [ freetype fontconfig ];

  LIBCLANG_PATH = "${llvmPackages_12.libclang.lib}/lib";

  meta = with lib; {
    homepage = "https://github.com/neetly/figma-agent-linux";
    description = "Font Helper for Figma for Linux x64 platform";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.rapherion ];
    mainProgram = "font-agent";
  };
}
