{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, llvmPackages_12
, freetype
, fontconfig
, ...
}:

rustPlatform.buildRustPackage {
  pname = "figma-agent-linux";
  version = "0.2.5";

  src = fetchFromGitHub {
    rev = "7f440e7a70e2de30c51b97bdcb5e7dd189311655";
    owner = "neetly";
    repo = "figma-agent-linux";
    sha256 = "sha256-cbGl/nqImbaOzETkPq/Occ0O4OPOQ1TM8tRQckG1cbg=";
  };

  cargoSha256 = "sha256-HjVIKwq4FWDr9jQ+2IXqEFkaVWlkQywV4t3KeorYywI=";

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
