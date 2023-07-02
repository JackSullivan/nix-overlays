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
      templates = {
        basic = {
          path = ./templates/basic.nix;
          description = "Basic flake for multisystem nixpkgs";
        };

        devShell = {
          path = ./templates/devShell.nix;
          description = "Basic flake for multisystem devShells";
        };
      };
    in { inherit overlays templates; };

}
