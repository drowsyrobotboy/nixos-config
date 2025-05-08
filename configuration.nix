# /etc/nixos/configuration.nix
# This is my main configuration file for NixOS system.

{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader for NVME Hosts
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader for SATA Hosts
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda";
  # boot.loader.grub.useOSProber = true;

  # Enable networking
  networking.hostName = "robotboy-code";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account.
  users.users.maruthi = {
    isNormalUser = true;
    description = "Maruthi";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  
  # Allow unfree packages. this is being handled in flake.nix
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    nodejs
    rustc
    cargo
    go
    vscode
    #ghostty
    gnome-tweaks
    gnomeExtensions.dash-to-panel
  ];
  
  # Install Firefox
  programs.firefox.enable = true;

  # Allows VSCode server to be installed from Host. THis allows Remote SSH from VSCode
  programs.nix-ld.enable = true;
  
  # Enable SSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no"; # Recommended for security
  services.openssh.settings.PasswordAuthentication = true; # Change to false if using SSH keys exclusively

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true; # This is throwing an error
  hardware.pulseaudio.enable = false; # Disable PulseAudio if using PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    # jack.enable = true;
  };

  # VMware guest integration
  virtualisation.vmware.guest.enable = true;

  # Firewall (enable and open ports as needed)
  # networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/manual/nixos/stable/).
  system.stateVersion = "24.11"; # Set to the version you are installing

}
