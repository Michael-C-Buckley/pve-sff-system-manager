{lib, ...}: let 
  sffNames = [ "sff1" "sff2" "sff3" ];
in {
  imports = [
    ./network.nix
  ];

  options.custom.sff.current = mkOption {
    type = types.enum sffNames;
    default = "sff1";
    description = "Which SFF instance should be used during individual evaluation";
  };

  config.custom.sff.current = config.networking.hostname;
}