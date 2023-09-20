{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf types;
  cfg = config.programs.maven;
  mvnAttrs = with types; let
    primitive = either str (either bool int);
    attr = either primitive (attrsOf primitive);
  in attrsOf (attrsOf attr);
  profileAttrs = with types; attrs;
    #(attrsOf (attrsOf mvnAttrs));
  mkSettingsXml = pkgs.callPackage ./settingsXml.nix {};
in {
  options.programs.maven = {
    enable = mkEnableOption "maven settings";
    package = mkOption {
      type = types.package;
      default = pkgs.maven3;
      defaultText = lib.literalExpression "pkgs.git";
      description = "maven package to use";
    };
    servers = mkOption {
      type = mvnAttrs;
      default = {};
      defaultText = lib.literalExpression "{}";
      description = "server attrs";
    };

    proxies = mkOption {
      type = mvnAttrs;
      default = {};
      defaultText = lib.literalExpression "{}";
      description = "proxies";
    };

    profiles = mkOption {
      type = with types; profileAttrs;
      default = {};
      defaultText = lib.literalExpression "{}";
      description = "profiles";
    };

    activeProfiles = mkOption {
      type = types.listOf types.str;
      default = [];
      defaultText = lib.literalExpression "[]";
      description = "active profiles";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file.".m2/settings.xml".source = mkSettingsXml cfg;
  };
}
