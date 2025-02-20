_: {
  imports = [
    ./sff1.nix
    ./sff2.nix
    ./sff3.nix
  ];

  custom.sff = {
    anycast.ipv4 = "192.168.61.4";
    gateway.ipv4 = "192.168.48.1";
  };
}