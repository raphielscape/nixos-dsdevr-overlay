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
      });

      nixosModules.figma-font-helper = import ./modules/figma-font-helper;
      packages.x86_64-linux = pkgs;
    };
}
