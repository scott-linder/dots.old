{ config, pkgs, ... }:

let
  lanGateway = "192.168.1.1";
  lanPrefixLength = 24;
  dhcpLower = "192.168.1.100";
  dhcpUpper = "192.168.1.254";
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "boron";
  networking.wireless.enable = false;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    git
    htop
    lm_sensors
    ntfs3g
    pciutils
    rxvt_unicode.terminfo
    unzip
    vim
    wget
    zip
  ];

  environment.variables.EDITOR = "vim";
  programs.bash.enableCompletion = true;

  services.openssh.enable = true;

  networking.firewall = {
    enable = true;
    allowPing = true;
    trustedInterfaces = [ "lo" "enp2s0" ];
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  networking.nat = {
    enable = true;
    internalIPs = [ "${lanGateway}/${(toString lanPrefixLength)}" ];
    externalInterface = "eno1";
  };

  networking.interfaces = {
    eno1 = {
      useDHCP = true;
    };

    enp2s0 = {
      ipv4.addresses = [
        { address = lanGateway; prefixLength = lanPrefixLength; }
      ];
    };
  };

  networking.extraHosts = ''
    ${lanGateway} ${config.networking.hostName}
  '';

  services.dnsmasq = {
    enable = true;
    servers = [ "8.8.8.8" "8.8.4.4" ];
    extraConfig = ''
      domain=lan
      interface=enp2s0
      bind-interfaces
      dhcp-range=${dhcpLower},${dhcpUpper},24h
      dhcp-authoritative
      expand-hosts
      domain-needed
    '';
  };

  users.extraUsers.scott = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "18.03";
}
