{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11-small";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, flake-utils, nixpkgs, system-manager }: {
    systemConfigs.default = system-manager.lib.makeSystemConfig {
      modules = [
        ./systemd
      ];
    };
  };
}