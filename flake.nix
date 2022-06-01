{
  description = "Packaging Isekai";

  outputs = { self }:
    let
      system = "x86_64-linux";
      pkgs = {
        inherit system;
        overlays = [
          self.overlay
        ];
      };
    in rec
    {
      overlay = (final: prev: rec {
        figma-font-helper = final.callPackage ./pkgs/figma-font-helper { };
        otf-san-francisco = final.callPackage ./pkgs/otf-san-francisco { };
        apple-cursor-theme = final.callPackage ./pkgs/apple-cursor-theme { };
        system76-scheduler = final.callPackage ./pkgs/system76-scheduler { };
      });

      nixosModules = {
        figma-font-helper = import ./modules/figma-font-helper;
        system76-scheduler = import ./modules/system76-scheduler;
      };
      packages.x86_64-linux = pkgs;
    };
}
