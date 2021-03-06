# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9905098a-a98e-4c37-8475-cd693a45c249";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8adafb71-3d05-42f5-88b7-215e36c0d19b"; }
    ];

  nix.maxJobs = 8;
}
