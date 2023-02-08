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
    systemd.user.services.figma-agent = {
      wantedBy = [ "default.target" ];
      unitConfig = {
        Description = "Figma Agent for Linux";
        Wants = [ "network-online.target" ];
        After = [ "network-online.target" ];
      };

      serviceConfig = {
        Type = "exec";
        ExecStart = "${pkgs.figma-agent-linux}/bin/figma-agent";
      };
    };

    systemd.user.sockets.figma-agent = {
      wantedBy = [ "sockets.target" ];
      unitConfig = {
        Description = "Figma Agent for Linux";
      };
      socketConfig = {
        ListenStream = 18412;
      };
    };
  };
}
