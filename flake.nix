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
      nixosModules = {
        maven = import ./modules/maven;
      };
    in { inherit overlays nixosModules; };

}
