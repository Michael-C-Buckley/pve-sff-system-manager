# SFF Networking

The networking stack here is slightly more sophisticated than many do for Proxmox.  This is a routed configuration, but using OSPF for dynamic routing.

It will change and grow with time, but for now makes routable loopback addresses the primary address for the cluster and includes a cluster anycast address as well.

Renaming PCIe device names is highly recommended for consistency and what `systemd-links.nix` does.

### Host Equipment

* 1 x onboard gigabit ethernet
* 2 x SFP+ (via Intel X520-DA2)