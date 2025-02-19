{config, ...}: let
  sff = config.custom.${config.custom.sff.current};
in {
  environment.etc."systemd/network/10-enx520p1".text = ''
    [Match]
    MACAddress=${sff.enx520p1.macAddress}

    [Link]
    Name=enx520p1
    MTUBytes=9000
  '';

  environment.etc."systemd/network/12-enx520p2".text = ''
    [Match]
    MACAddress=${sff.enx520p2.macAddress}

    [Link]
    Name=enx520p2
    MTUBytes=9000
  '';
}