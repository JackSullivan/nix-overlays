{
  description = "Personal overlays";

  outputs = { self }:
    let
      overlaySet = {
        lib = import ./overlays/lib.nix;
        pkgs = import ./overlays/pkgs.nix;
      };
      overlay = final: prev:
        prev.lib.composeManyExtensions (prev.lib.attrValues overlaySet);
      overlays = overlaySet // { default = overlay; };
      templates = let
        basic = {
          path = ./templates/basic;
          description = "Basic flake for multisystem nixpkgs";
        };
      in {
        inherit basic;
        default = basic;
        devShell = {
          path = ./templates/devShell;
          description = "Basic flake for multisystem devShells";
        };
      };
      nixosModules = { maven = import ./modules/maven; };
    in { inherit overlays templates nixosModules; };

}
