{ config, pkgs, ... }:

{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  # Workaround for dell xps 13
  boot.kernelParams = [ "video=SVIDEO-1:d" ];

  networking.hostName = "hafnium"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config = {
    allowUnfree = true;

    firefox = {
      enableGoogleTalkPlugin = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    cockatrice
    evince
    fd
    ffmpeg-full
    file
    firefox
    gcc
    git
    gnumake
    gnupg
    go_bootstrap
    gotools
    htop
    i3
    jre
    keepassx2
    keybase
    lm_sensors
    mpv
    ntfs3g
    obs-studio
    openconnect
    openldap
    openvpn
    pavucontrol
    pciutils
    python36
    python36Packages.virtualenv
    ripgrep
    ruby
    rxvt_unicode
    scrot
    stoken
    sxiv
    teamviewer
    texlive.combined.scheme-full
    unzip
    vim_configurable
    wine
    winetricks
    xdg-user-dirs
    xorg.xbacklight
    xorg.xev
    xorg.xmodmap
    youtubeDL
    zip
  ];

  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.ssh.startAgent = true;

  # List services that you want to enable:

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.teamviewer.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    extraSessionCommands =
      ''
      xmodmap ~/.xmodmap
      '';
  };
  services.xserver.windowManager.default = "i3";
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "scott";
  };
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  #services.openvpn.servers = {
  #  home = {
  #    config =
  #      ''
  #      client
  #      dev tun
  #      proto udp
  #      remote boron.scottlinder.com 1195
  #      resolv-retry infinite
  #      nobind
  #      ca /root/.vpn/ca.crt
  #      cert /root/.vpn/client1.crt
  #      key /root/.vpn/client1.key
  #      remote-cert-tls server
  #      tls-auth /root/.vpn/ta.key 1
  #      cipher AES-256-CBC
  #      '';
  #    up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
  #    down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
  #    autoStart = false;
  #  };
  #};

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts
  ];

  hardware.opengl.driSupport32Bit = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.scott = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "sound" "dialout" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
