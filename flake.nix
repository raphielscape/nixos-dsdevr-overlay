{
  description = "Packaging Isekai";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  outputs = flakes': let
    flakes = {
      nixpkgs = flakes'.nixpkgs.legacyPackages.x86_64-linux;
      lib = flakes'.nixpkgs.lib;
      self = flakes'.self.packages.x86_64-linux;
    };
  in {
    packages.x86_64-linux.figma-agent-linux = import ./pkgs/figma-agent-linux flakes;
    packages.x86_64-linux.otf-san-francisco = import ./pkgs/otf-san-francisco flakes;
    packages.x86_64-linux.apple-cursor-theme = import ./pkgs/apple-cursor-theme flakes;
    packages.x86_64-linux.posy-cursor-theme = import ./pkgs/posy-cursor-theme flakes;
    packages.x86_64-linux.system76-scheduler = import ./pkgs/system76-scheduler flakes;

    nixosModules = {
        figma-font-helper = import ./modules/figma-font-helper;
        figma-agent-linux = import ./modules/figma-agent-linux;
        system76-scheduler = import ./modules/system76-scheduler;
      };
  };
}
