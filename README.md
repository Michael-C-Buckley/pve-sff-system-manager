# SFF PVE Cluster

This is a 3-node Proxmox cluster I use in my home lab to host some services and train on.

They consist of HP Prodesk G4 600 SFF units with the following:

* Intel 8500
* 24 GB RAM (SFF1 has 40)
* 1 onboard Ethernet NIC
* Intel X520-DA2 via PCIe
* 500 GB NVMe
* 4 TB HDD

It was a low-cost cluster with reasonable amount of resources available for small to intermediate workloads.

## The Project Intent

This started as a means to see if it was reasonable to curtail the issues with managing multiple Proxmox boxes.  Nix was selected as tooling because of my familiarity with it and usefulness.

I will be completing the build-out, then creating a template for others, if they wish to use for their host/cluster managements.  There will be a single host and cluster template.

While other tooling does exist, it is far less efficient and much more tedious to use than Nix-based solutions.

## Nix Configuration

I am currently using `System-Manager` to help with corralling otherwise scattered configuration files in this repo.  I do also use `Home-Manager` for my user environment.

The end result is very satisfying as a NixOS heavy user, since it's a sane way to manage the system in one place and make it reproducible across the cluster.

## Tooling

I do have a few Ansible playbooks to help with my cluster management, they are nested under the `tools` directory.  Right now, just Ansible exists but more may be included if needed.