{pkgs, ...}: {
  imports = [
    ./configs
    ./hosts
    ./options
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    frr
  ];
}