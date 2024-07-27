{ lib }:

cfg:
let
  inherit (lib.attrsets) mapAttrsToList optionalAttrs;
  inherit (lib.generators) toXMLFile;
  servers.server =
    mapAttrsToList (id: server: { inherit id; } // server) cfg.servers;
  proxies.proxy =
    mapAttrsToList (id: proxy: { inherit id; } // proxy) cfg.proxies;
  mkRepositories = repos: {
    repository =
      mapAttrsToList (id: repository: { inherit id; } // repository) repos;
  };
  # repositories.repository = mapAttrsToList (id: repository: {inherit id;} // repository) cfg.repositories;
  profiles.profile = mapAttrsToList (id:
    args@{ repositories, ... }:
    {
      inherit id;
      repositories = mkRepositories repositories;
    } // (optionalAttrs (builtins.hasAttr "properties" args) {
      properties = args.properties;
    })) cfg.profiles;
  activeProfiles.activeProfile = cfg.activeProfiles;
in toXMLFile {
  name = "settings.xml";
  attrs.settings = { inherit servers proxies profiles activeProfiles; };
}
