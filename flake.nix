{
  description = "Packaging Isekai";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-fmt, ... }:
    let
      linux = [ "x86_64-linux" ];
      darwin = [ "aarch64-darwin" "x86_64-darwin" ];

      pkgsFor = system: import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in
    {
      nixosModules = {
        "figma-agent-linux" = import ./modules/figma-agent-linux;
        "system76-scheduler" = import ./modules/system76-scheduler;
      };

      overlays =
        {
          applications = _: prev: {
            system76-scheduler =
              prev.callPackage ./pkgs/system76-scheduler { };
          };

          designkit = _: prev: {
            figma-agent-linux =
              prev.callPackage ./pkgs/figma-agent-linux { };
          };

          fonts = _: prev: {
            sf-pro = prev.callPackage ./pkgs/sf-pro { };
          };

          cursors = _: prev: {
            apple-cursor-theme =
              prev.callPackage ./pkgs/apple-cursor-theme { };
          };

          darwin = final: prev: with self.overlays;
            (fonts final prev);

          linux = final: prev: with self.overlays;
            (applications final prev)
            // (designkit final prev)
            // (fonts final prev)
            // (cursors final prev);

          default = self.overlays.linux;
        };

      packages = (nixpkgs.lib.genAttrs linux (system:
        let
          pkgs = pkgsFor system;
        in
        builtins.removeAttrs (self.overlays.linux pkgs pkgs) [ "lib" ]
      ))
      //
      (nixpkgs.lib.genAttrs darwin (system:
        let
          pkgs = pkgsFor system;
        in
        builtins.removeAttrs (self.overlays.darwin pkgs pkgs) [ "lib" ]
      ));

      formatter = nixpkgs.lib.genAttrs (darwin ++ linux) (system: nixpkgs-fmt.defaultPackage.${system});
    };
}
