final: prev:

let
  libgomp1 = prev.stdenvNoCC.mkDerivation rec {
    name = "libgomp1";
    src = prev.llvmPackages.openmp;
    buildCommand = ''
      mkdir -p $out/lib
      ln -s $src/lib/libgomp.so $out/lib/libgomp.so.1
    '';
  };
  rdrview = prev.callPackage ../pkgs/rdrview.nix {};
in {
 inherit libgomp1 rdrview;
}
