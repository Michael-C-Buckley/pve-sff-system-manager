{pkgs, ...}: {
  imports = [
    ./configs
    ./hosts
    ./options
  ];

  system-manager.allowAnyDistro = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    frr
  ];
}