{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11-small";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, system-manager }: let
    sffMembers = [ "sff1" "sff2" "sff3" ];
    sffConfig = {host}: system-manager.lib.makeSystemConfig {
      modules = [
        ./base.nix
        ./hosts/${host}
      ];
    };
  in {
    systemConfigs = builtins.listToAttrs (map (host: {
      name = host;
      value = sffConfig {inherit host;};
    }) sffMembers);
  };
}