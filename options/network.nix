{lib, ...}: let
  inherit (lib) mkOption types genAttrs;
  stringOption = desc: mkOption {
    type = types.str;
    default = "";
    description = desc;
  };

  sffNames = [ "sff1" "sff2" "sff3" ];

  # Generate and adds these to the custom option set
  sffOptions = genAttrs sffNames (name: {
    lo.ipv4 = stringOption "IPv4 loopback address to add to ${name}'s lo";
    vmbr0.ipv4 = stringOption "IPv4 address to add to ${name}'s default bridge";
    gateway.ipv4 = stringOption "IPv4 default gateway address";

    enx520p1 = {
      ipv4 = stringOption "IPv4 address to add to ${name}'s Intel X520 port 1";
      macAddress = stringOption "The MAC address of ${name}'s Intel X520 port 1"
    };
  });
in {
  # Common options that are evaluated as the member who ran the flake
  options.custom = sffOptions // {
    sff = {
      anycast.ipv4 = stringOption "The cluster's IPv4 anycast address";
    };
  };
}