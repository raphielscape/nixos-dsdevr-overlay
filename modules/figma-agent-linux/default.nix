{ config
, pkgs
, lib
, ...
}:

with lib; let
  inherit (pkgs) stdenv;
  cfg = config.services.figma-agent-linux;
in
{
  options.services.figma-agent-linux = {
    enable = mkEnableOption "figma-agent-linux";
  };

  config = mkIf (cfg.enable && stdenv.isLinux) {
    systemd.services.figma-agent-linux = {
      wantedBy = [ "default.target" ];
      unitConfig = {
        Description = "Figma Agent for Linux";
        After = [ "graphical-session.target" ];
      };

      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.figma-agent-linux}/bin/figma-agent";
        Restart = "on-failure";
      };
    };
  };
}
