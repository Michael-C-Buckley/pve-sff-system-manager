{config, ...}: {
  custom = {
    sff.current = config.custom.sff2;

    sff3 = {
      vmbr0.ipv4 = "192.168.48.23/24";
      gateway.ipv4 = "192.168.48.1";
      enx520p1 = {
        ipv4 = "";
        macAddress = "90:e2:ba:60:01:b8";
      };
      enx520p2 = {
        macAddress = "90:e2:ba:60:01:b9";
      };
    };
  };
}