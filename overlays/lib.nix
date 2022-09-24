final: prev:

let
  inherit (prev.lib) recursiveUpdate readFile;
  inherit (prev) runCommand writeTextFile;
  inherit (prev.lib.generators) toJSON;
  py = prev.python3.withPackages (p: [ p.xmltodict p.pyyaml ]);
  toXMLFile = { name, attrs, destination ? "" }:
    let
      intermediate = writeTextFile {
        name = "${name}.json";
        text = toJSON { } attrs;
      };
    in runCommand name { } ''
      n=$out${destination}
      mkdir -p "$(dirname "$n")"

      ${py}/bin/python ${./json-to-xml.py} ${intermediate} $n
    '';
  toXML = attrs:
    readFile (toXMLFile {
      name = "auto";
      inherit attrs;
    });
  toYAMLFile = { name, attrs, destination ? "" }:
    let
      intermediate = writeTextFile {
        name = "${name}.json";
        text = toJSON { } attrs;
      };
    in runCommand name { } ''
      n=$out${destination}
      mkdir -p "$(dirname "$n")"

      ${py}/bin/python ${./json-to-yaml.py} ${intermediate} $n
    '';
  toYAML = attrs:
    readFile (toYAMLFile {
      name = "auto";
      inherit attrs;
    });
in {
  lib = prev.lib // {
    generators = {
      inherit toXMLFile toXML toYAMLFile toYAML;
    } // prev.lib.generators;
  };
}
