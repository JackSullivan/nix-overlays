{
  description = "Basic flake for multisystem nixpkgs";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
    };
  });
}
