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
        figma-agent-linux = final.callPackage ./pkgs/figma-agent-linux { };
        otf-san-francisco = final.callPackage ./pkgs/otf-san-francisco { };
        apple-cursor-theme = final.callPackage ./pkgs/apple-cursor-theme { };
        posy-cursor-theme = final.callPackage ./pkgs/posy-cursor-theme { };
        system76-scheduler = final.callPackage ./pkgs/system76-scheduler { };
      });

      nixosModules = {
        figma-font-helper = import ./modules/figma-font-helper;
        figma-agent-linux = import ./modules/figma-agent-linux;
        system76-scheduler = import ./modules/system76-scheduler;
      };
      packages.x86_64-linux = pkgs;
    };
}
