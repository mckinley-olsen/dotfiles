# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader = {
    gummiboot.enable = true;
    #grub.enable = false;
    #generationsDir = {
    #  enable = true;
    #  copyKernels = true;
    #};
    efi = {
      canTouchEfiVariables = true;
      efibootmgr = {
        efiDisk = "/dev/sdb";
        efiPartition = 10;
      };
    };
    #generationsDir.copyKernels = true;
    #generationsDir.enable = true;
    #efiBootStub.enable = true;
  };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1118-75FB";
      fsType = "vfat";
    };

  /*
  using this style to define networking options causes odd behavior; causes a static connection to be created, forcing explicit designation of nameservers
  using long form above allows nameservers to be designated via dhcp
  networking = {
    hostName = "molsen"; # Define your hostname.
    networkmanager.enable = true;
    #nameservers = [ "8.8.8.8" "8.8.4.4" ];
  };
  */
  networking.networkmanager.enable = true;
  networking.hostName = "molsen";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Denver";
  nixpkgs.config = {
    allowUnfree = true;
    firefox = {
      enableAdobeFlash = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    emacs
    git
    stow
    i3status

    i3blocks
    acpi

    dmenu
    networkmanager
    networkmanagerapplet
    networkmanager_openconnect
    openconnect
    gnome3.dconf
    termite
    bash

    firefox-wrapper
    profile-sync-daemon
    powerline-fonts

    #hibernate
    pmutils

    pciutils

    bar-xft
    #conky
    python34
    python34Packages.powerline
    python34Packages.i3-py

    unzip

    #shell
    zsh
    curl

    chromium
    xorg.xbacklight

    #audio
    pulseaudioFull
    pavucontrol
    udev

  ];

  fonts.fontconfig.dpi = 200;
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  programs = {
      zsh.enable = true;
  };

  services = {
    psd = {
      enable = true;
      users = [ "mckinley" ];
    };
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:nocaps";
      synaptics.enable = true;

      windowManager.i3.enable = true;
      displayManager.sessionCommands = "${pkgs.networkmanagerapplet}/bin/nm-applet &";
      vaapiDrivers = [ pkgs.vaapiIntel ];
      videoDrivers = [ "nvidia" "intel" ];
    };
    udev.extraRules = ''
          ACTION=="add", KERNEL=="0000:00:1d.0", SUBSYSTEM=="pci", RUN+="${pkgs.bash}/bin/bash -c 'echo EHC1 > /proc/acpi/wakeup'"
          ACTION=="add", KERNEL=="0000:00:1a.0", SUBSYSTEM=="pci", RUN+="${pkgs.bash}/bin/bash -c 'echo EHC2 > /proc/acpi/wakeup'"
          ACTION=="add", KERNEL=="0000:00:14.0", SUBSYSTEM=="pci", RUN+="${pkgs.bash}/bin/bash -c 'echo XHC > /proc/acpi/wakeup'"
          '';
  };

  hardware.bumblebee.enable = true;
  hardware.bumblebee.driver = "nvidia";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.desktopManager.xfce.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  hardware.pulseaudio.enable = true;

  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    # Define a user account. Don't forget to set a password with ‘passwd’.
    extraUsers.mckinley = {
      isNormalUser = true;
      home = "/home/mckinley";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
}
