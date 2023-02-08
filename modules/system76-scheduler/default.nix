{ config
, lib
, pkgs
, ...
}:

with lib; let
  cfg = config.services.system76-Scheduler;
  servicename = "com.system76.Scheduler";
in
{
  options = {
    services.system76-Scheduler = {
      enable = mkEnableOption "Automatically configure CPU scheduler for responsiveness on AC";
    };
  };

  config = mkIf cfg.enable {
    systemd = {
      packages = [ pkgs.system76-scheduler ];
      services."${servicename}" = {
        wantedBy = [ "default.target" ];
      };
    };
  };
}
