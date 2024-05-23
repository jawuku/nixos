# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";

  # change username, description and hostname to suit your own
  defaultUser = "jason";
  userDescription = "Jason Awuku";
  host-name = "chatreey-t9";
in

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Intel graphics drivers
      ./intel-graphics.nix

      # Incorporate Home Manager
      (import "${home-manager}/nixos")
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 15;
    };
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = host-name; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
    enable = true;
    # Filter out certain websites
    # using CloudFlare's `1.1.1.1 for Families`
    # https://blog.cloudflare.com/introducing-1-1-1-1-for-families/
    insertNameservers = [
      "1.1.1.3"
      "1.0.0.3"
      "2606:4700:4700::1113"
      "2606:4700:4700::1003"
    ];
  };
  
  programs.nm-applet.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable X11 windowing system
  services.xserver = {
    enable = true;

    # Enable SDDM
    displayManager.sddm = {
      enable = true;
      wayland.enable = false;
    };

    # Enable Openbox
    windowManager.openbox.enable = true;

    # Set Openbox to be the default selection in SDDM
    displayManager.defaultSession = "none+openbox";

    # Configure keymap in X11
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # And enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  # Enable sound with PipeWire
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable media keys in Openbox
  sound.mediaKeys.enable = true;

  # Enable Policykit (sudo access for GUI apps)
  security.polkit.enable = true;

  # Define a user account. Password is stored in encrypted sha-512 format.
  users.users.${defaultUser} = {
    isNormalUser = true;
    description = userDescription;
    # generate hashed password with the following on the command line:
    # nix-shell -p openssl
    # openssl passwd -6
    # <enter your password twice>
    # copy and paste hash below
    hashedPassword = "$6$eW5d0Mgir.RNpkus$jyS.sgPUddUhSimmbCAK7TUmSGvn2WQEpG3eUMeHg4gVMojGKVem92kIwYGGJK/G3RDfDMwiInq3oRdE3Vg.W1";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    # packages = with pkgs; [];
  };

  # Enable Home manager for user
  home-manager = {
    users = {
      ${defaultUser} = {
        imports = [ ./home.nix ];
      };
    };
    useGlobalPkgs = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix!
    # The Nano editor is also installed by default.
    wget
    git
    nix-prefetch-git
    fd
    ripgrep
    tealdeer
    gcc
    unzip
    zip
    p7zip
    distrobox
    ntfs3g # to access Windows disks / partitions
    xidlehook
    killall
  ];

  # GUI Fonts - Nerd Fonts, Google and Microsoft
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "RobotoMono" "FiraCode" ]; })
    noto-fonts
    noto-fonts-extra
    corefonts
    vistafonts
  ];

  # Virt-Manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Podman / Docker Support
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable Thunar, plugins and other functionalites
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  programs.xfconf.enable = true; # to save configuration changes

  services.gvfs.enable = true; # to enable recycle bin

  services.tumbler.enable = true; # image thumbnails

  # Bash settings
  programs.bash = {
    # Custom bash prompt via kirsle.net/wizards/ps1.html
    promptInit = ''
      PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
    '';
  };

  # MySQL / MariaDB
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Copy this NixOS configuration fille and link to
  # (/run/current-system/configuration.nix). Useful in case of accidental deletion
  system.copySystemConfiguration = true;

  # automatic upgrade
  system.autoUpgrade.enable = true;

  # Automatic garbage collection
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
