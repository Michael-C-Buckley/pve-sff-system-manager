_: {
  systemd.network = {
    links = {
      # Rename the Intel X520-DA2 cards
      "10-ente1" = {
        matchConfig.MACaddress = "";
        linkConfig = {
          name = "ente1";
          MTUBytes = 9000;
        };
      };
      "11-ente2" = {
        matchConfig.MACaddress = "";
        linkConfig = {
          name = "ente2";
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