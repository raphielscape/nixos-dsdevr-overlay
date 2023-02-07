{ lib
, pkgs
, fetchFromGitHub
, rustPlatform
, perf-tools
}:

rustPlatform.buildRustPackage rec {
  pname = "system76-scheduler";
  version = "1.2.1";

  src = fetchFromGitHub {
    rev = "${version}";
    owner = "pop-os";
    repo = "system76-scheduler";
    sha256 = "sha256-Qz4LT+YluuQj9uke2pmFL2X8CYdpOoB70MxjYCyVf+g=";
  };

  cargoSha256 = "sha256-ZbAEeHKALp0S0RwcJOINyp7uueWnXny4Crkl+qEEKyQ=";

  EXECSNOOP_PATH = "${lib.makeBinPath [ perf-tools ]}/execsnoop";

  buildInputs = [ perf-tools ];

  postPatch = ''
    substituteInPlace "daemon/src/config.rs" \
      --replace "/usr/share/system76-scheduler/" "$out/share/system76-scheduler/"
  '';

  postInstall = ''
    mkdir -p $out/share/system76-scheduler/assignments \
        $out/share/system76-scheduler/exceptions
    install -Dm0644 data/config.ron $out/share/system76-scheduler/config.ron
    install -Dm0644 data/assignments.ron $out/share/system76-scheduler/assignments/default.ron
    install -Dm0644 data/exceptions.ron $out/share/system76-scheduler/exceptions/default.ron
    install -Dm0644 data/com.system76.Scheduler.service $out/lib/systemd/system/com.system76.Scheduler.service
    install -Dm0644 data/com.system76.Scheduler.conf $out/share/dbus-1/system.d/com.system76.Scheduler.conf

    substituteInPlace $out/lib/systemd/system/com.system76.Scheduler.service \
        --replace "/usr/bin/system76-scheduler" "$out/bin/system76-scheduler"
  '';

  meta = with lib; {
    homepage = "https://github.com/pop-os/system76-scheduler";
    description = "Auto-configure CFS and process priorities for improved desktop responsiveness";
    license = licenses.mpl20;
    platforms = platforms.linux;
    maintainers = [ maintainers.rapherion ];
    mainProgram = "system76-scheduler";
  };
}
