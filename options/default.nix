{lib, ...}: let
  inherit (lib) mkOption types;
  sffNames = [ "sff1" "sff2" "sff3" ];
in {
  imports = [
    ./network.nix
  ];

  options.custom.sff = {
    current = mkOption {
      type = types.enum sffNames;
      description = "Which SFF instance should be used during individual evaluation";
    };
    members = mkOption {
      type = types.listOf types.str;
      default = [ "sff1" "sff2" "sff3" ];
      description = "The hostname list of the members of the cluster";
    };
  };
}