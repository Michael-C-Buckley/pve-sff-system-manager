_: {
  imports = [
    # ./frr.nix
    ./network-interfaces.nix
    ./systemd.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  custom = {
    sff.anycast.ipv4 = "192.168.61.4";
    sff1.lo.ipv4 = "192.168.61.5";
    sff2.lo.ipv4 = "192.168.61.6";
    sff3.lo.ipv4 = "192.168.61.7";
  }
}