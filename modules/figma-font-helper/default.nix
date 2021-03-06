{ config, pkgs, lib, ... }:

with lib; let
  inherit (pkgs) stdenv;
  cfg = config.services.figma-font-helper;
in
{
  options.services.figma-font-helper = {
    enable = mkEnableOption "figma-font-helper";

    port = mkOption {
      type = types.str;
      default = "18412";
      description = "Figma font helper service port.";
    };

    directories = mkOption {
      type = types.listOf types.str;
      default = [ "/usr/share/fonts" ];
      description = "Figma font helper service lookup font directories.";
    };
  };

  config = mkIf (cfg.enable && stdenv.isLinux) {
    environment.etc = {
      "figma-linux/fonthelper".text = builtins.toJSON {
        port = cfg.port;
        directories = cfg.directories;
      };
    };

    systemd.services.figma-font-helper = {
      unitConfig = {
        Description = "Font Helper for Figma";
        After = [ "graphical-session.target" ];
        wantedBy = [ "default.target" ];
      };

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.figma-font-helper}/bin/fonthelper";
        Restart = "on-failure";
      };
    };
  };
}
