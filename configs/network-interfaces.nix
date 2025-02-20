{config, ...}: let
  sff = config.custom.${config.custom.sff.current};
in {
  environment.etc."network/interfaces".text = ''
    auto lo
    iface lo inet loopback
      address ${sff.lo.ipv4}
      address ${config.custom.sff.anycast.ipv4}
      post-up iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8006
      post-up iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8006

    iface lo inet6 auto
      post-up ip6tables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-ports 8006
      post-up ip6tables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8006

    iface eno1 inet manual

    auto vmbr0
    iface vmbr0 inet static
      address ${sff.vmbr0.ipv4}
      gateway ${config.custom.sff.gateway.ipv4}
      bridge-ports eno1
      bridge-stp off
      bridge-fd 0
            

    iface vmbr0 inet6 auto
       post-up sysctl net.ipv6.conf.vmbr0.disable_ipv6=0
       post-up sysctl net.ipv6.conf.vmbr0.accept_ra=2
       post-up sysctl net.ipv6.conf.vmbr0.autoconf=1
       

    auto enx520p1
    iface enx520p1 inet static
      address ${sff.enx520p1.ipv4}

    iface enx520p2 inet manual

    source /etc/network/interfaces.d/*
  '';
}