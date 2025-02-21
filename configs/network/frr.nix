{config, ...}: let
  sff = config.custom.${config.custom.sff.current};

  ospfCommon = ''
  ip ospf area 0
  ip ospf hello-interval 1
  ip ospf dead-interval 3
  '';
in {
  environment.etc."frr/frr.conf".text = ''
    ip forwarding
    ipv6 forwarding

    router ospf
      router-id ${sff.lo.ipv4}

    # WIP: filter out localhost advertisements

    int lo
      ip ospf area 0
      ip ospf passive
    int eno1
      ip ospf cost 400
      ${ospfCommon} 
    int enx520p1
      ip ospf cost 40
      ${ospfCommon} 
  '';

  environment.etc."frr/daemons".text = ''
  MAX_FDS=2048

  # Daemons to use
  bgpd=yes
  ospfd=yes
  ospf6d=yes
  ripd=no
  ripngd=no
  isisd=no
  pimd=no
  pim6d=no
  ldpd=yes
  nhrpd=no
  eigrpd=no
  babeld=no
  sharpd=no
  pbrd=no
  bfdd=yes
  fabricd=no
  vrrpd=no
  pathd=no

  # Options
  vtysh_enable=yes
  zebra_options="  -A 127.0.0.1 -s 90000000"
  bgpd_options="   -A 127.0.0.1"
  ospfd_options="  -A 127.0.0.1"
  ospf6d_options=" -A ::1"
  ripd_options="   -A 127.0.0.1"
  ripngd_options=" -A ::1"
  isisd_options="  -A 127.0.0.1"
  pimd_options="   -A 127.0.0.1"
  pim6d_options="  -A ::1"
  ldpd_options="   -A 127.0.0.1"
  nhrpd_options="  -A 127.0.0.1"
  eigrpd_options=" -A 127.0.0.1"
  babeld_options=" -A 127.0.0.1"
  sharpd_options=" -A 127.0.0.1"
  pbrd_options="   -A 127.0.0.1"
  staticd_options="-A 127.0.0.1"
  bfdd_options="   -A 127.0.0.1"
  fabricd_options="-A 127.0.0.1"
  vrrpd_options="  -A 127.0.0.1"
  pathd_options="  -A 127.0.0.1"
  '';
}