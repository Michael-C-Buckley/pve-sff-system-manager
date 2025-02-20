{config, ...}: let
  sff = config.custom.${config.custom.sff.current};
in {
  environment.etc."frr/".text = ''
    # WIP
  '';
}