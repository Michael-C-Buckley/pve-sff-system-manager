{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-devshells = {
      url = "github:Michael-C-Buckley/nix-devshells";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, system-manager, nix-devshells, ... }: let
    sffMembers = [ "sff1" "sff2" "sff3" ];
    sffConfig = {host}: system-manager.lib.makeSystemConfig {
      modules = [
        ./base.nix
        {custom.sff.current = host;}
      ];
    };
  in {
    devShells.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux; mkShell {
      inherit (nix-devshells.devShells.x86_64-linux.nixosServers) buildInputs;
      shellHook = let
        inv = "-i tools/ansible/inventory.ini";
        playbook = "ansible-playbook ${inv} tools/ansible/";
      in ''
        ${nix-devshells.devShells.x86_64-linux.nixos.shellHook or ""}
        # Ansible Shortcuts
        alias sffh='ansible ${inv} -m command -a "home-manager switch --flake github:Michael-C-Buckley/nixos"
        alias sffs='${playbook}system-manager.yml'
        alias sffreboot='${playbook}reboot.yml'
        alias sffpoweroff='${playbook}shutdown.yml'
      '';
    };
    systemConfigs = builtins.listToAttrs (map (host: {
      name = host;
      value = sffConfig {inherit host;};
    }) sffMembers);
  };
}
