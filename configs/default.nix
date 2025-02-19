_: {
  imports = [
    ./systemd.nix
  ];

  # 
  environment.etc = {
    "network/interfaces".text = {};
  };
}