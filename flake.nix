{
  description = "A soothing pastel theme for SDDM";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      version = builtins.substring 0 8 self.lastModifiedDate;

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: function (import nixpkgs { inherit system; }));

      mkDate =
        longDate:
        (nixpkgs.lib.concatStringsSep "-" [
          (builtins.substring 0 4 longDate)
          (builtins.substring 4 2 longDate)
          (builtins.substring 6 2 longDate)
        ]);
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          name = "catppuccin-sddm-corners-shell";

          buildInputs = [ pkgs.kdePackages.sddm ];
        };
      });

      overlays.default = final: prev: {
        catppuccin-sddm-corners = final.callPackage ./nix/default.nix {
          version =
            version
            + "+date="
            + (mkDate (self.lastModifiedDate or "19700101"))
            + "_"
            + (self.shortRev or "dirty");
        };
      };

      # Provide some binary packages for selected system types.
      packages = forAllSystems (
        pkgs:
        let
          packages = self.overlays.default pkgs pkgs;
        in
        packages // { default = packages.catppuccin-sddm-corners; }
      );
    };
}
