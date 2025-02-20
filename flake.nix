{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11-small";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-devshells = {
      url = "github:Michael-C-Buckley/nix-devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { system-manager, nix-devshells }: let
    sffMembers = [ "sff1" "sff2" "sff3" ];
    sffConfig = {host}: system-manager.lib.makeSystemConfig {
      modules = [
        ./base.nix
        {custom.sff.current = host;}
      ];
    };
  in {
    devShells.x86_64-linux.default = nix-devshells.devShells.x86_64-linux.nixosServers;
    systemConfigs = builtins.listToAttrs (map (host: {
      name = host;
      value = sffConfig {inherit host;};
    }) sffMembers);
  };
}