_: {
  systemd.network = {
    links = {
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
}