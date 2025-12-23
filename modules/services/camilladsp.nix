{pkgs, ...}: let
  config = pkgs.writeText "dsp.yaml" ''
    title: "Sennheiser Momentum 4 Passive EQ"
    description: "EQ for Sennheiser Momentum 4 Passive mode to be neutral"
    devices:
      samplerate: 192000
      chunksize: 4096
      capture:
        type: Alsa
        channels: 2
        device: "hw:Loopback,1"
        format: S32LE
      playback:
        type: Alsa
        channels: 2
        device: "hw:S3,0,0"
        format: S32LE
    pipeline:
      - type: Filter
        channels: [0, 1]
        names:
          - gain_preamp
          - filter1
          - filter2
          - filter3
          - filter4
          - filter5
          - filter6
          - filter7
          - filter8
          - filter9
          - filter10
          - filter11
          - filter12
    filters:
      gain_preamp:
        type: Gain
        parameters:
          gain: -14.0
      filter1:
        type: Biquad
        parameters:
          type: Peaking
          freq: 20
          gain: 3.0
          q: 2.0
      filter2:
        type: Biquad
        parameters:
          type: Peaking
          freq: 38
          gain: 8.9
          q: 0.5
      filter3:
        type: Biquad
        parameters:
          type: Peaking
          freq: 55
          gain: -1.6
          q: 0.7
      filter4:
        type: Biquad
        parameters:
          type: Peaking
          freq: 69
          gain: 3.8
          q: 2.0
      filter5:
        type: Biquad
        parameters:
          type: Peaking
          freq: 110
          gain: -1.8
          q: 1.8
      filter6:
        type: Biquad
        parameters:
          type: Peaking
          freq: 290
          gain: 3.8
          q: 0.8
      filter7:
        type: Biquad
        parameters:
          type: Peaking
          freq: 970
          gain: -11.9
          q: 1.7
      filter8:
        type: Biquad
        parameters:
          type: Peaking
          freq: 2100
          gain: 5.7
          q: 1.8
      filter9:
        type: Biquad
        parameters:
          type: Peaking
          freq: 3500
          gain: 11.9
          q: 0.5
      filter10:
        type: Biquad
        parameters:
          type: Peaking
          freq: 4100
          gain: -7
          q: 2.0
      filter11:
        type: Biquad
        parameters:
          type: Peaking
          freq: 5500
          gain: 4
          q: 2.0
      filter12:
        type: Biquad
        parameters:
          type: Peaking
          freq: 15000
          gain: 5.9
          q: 0.5
  '';
in {
  # https://github.com/HEnquist/camilladsp-config/blob/ac18c5b23405928d4e1d81b962b8dd23ebf1f092/camilladsp.service
  systemd.services.camilladsp = {
    after = ["syslog.target"];
    startLimitIntervalSec = 10;
    startLimitBurst = 10;
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.camilladsp}/bin/camilladsp ${config}";
      Restart = "always";
      RestartSec = 1;
      StandardOutput = "syslog";
      StandardError = "syslog";
      SyslogIdentifier = "camilladsp";
      User = "root";
      Group = "root";
      CPUSchedulingPolicy = "fifo";
      CPUSchedulingPriority = "10";
    };
  };
}
