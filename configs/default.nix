{pkgs, ...}: {
  imports = [
    # ./frr.nix
    ./network-interfaces.nix
    ./systemd.nix
  ];
}