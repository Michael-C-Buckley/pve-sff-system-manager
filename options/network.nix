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
  });
in {
  # Common options that are evaluated as the member who ran the flake
  options.custom = sffOptions // {
    sff = {
      anycast.ipv4 = stringOption "The cluster's IPv4 anycast address";
    };
  };
}