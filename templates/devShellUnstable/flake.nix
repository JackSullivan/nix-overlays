{
  description = "A very basic flake";

  inputs = 

  outputs = { self, nixpkgs, nixpkgs-unstable,flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
    let pkgs = nixpkgs.legacyPackages.${system};
        unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [];
      };
    });

}
