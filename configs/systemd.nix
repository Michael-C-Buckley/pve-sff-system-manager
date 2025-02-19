_: {
  systemd.network = {
    links = {
      # Rename the Intel X520-DA2 cards
      "10-enx520p1" = {
        matchConfig.MACaddress = "";
        linkConfig = {
          name = "enx520p1";
          MTUBytes = 9000;
        };
      };
      "11-enx520p2" = {
        matchConfig.MACaddress = "";
        linkConfig = {
          name = "enx520p2";
          MTUBytes = 9000;
        };
      };
    };
  };
  
  networking = {
    # Hosts File
    hosts = {};
  };
}