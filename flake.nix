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
        rootcmd = "ansible sff_hosts_as_root ${inv} -m command -a ";
      in ''
        ${nix-devshells.devShells.x86_64-linux.nixos.shellHook or ""}
        # Ansible Shortcuts
        alias hms='${playbook}home-manager.yml'
        alias sms='${playbook}system-manager.yml'
        alias sffreboot='${rootcmd} "reboot"'
        alias sffpoweroff='${rootcmd} "shutdown now"'
      '';
    };
    systemConfigs = builtins.listToAttrs (map (host: {
      name = host;
      value = sffConfig {inherit host;};
    }) sffMembers);
  };
}