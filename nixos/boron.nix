{ config, pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "boron";
  networking.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    steam
  ];

  # For steam
  hardware.pulseaudio.support32Bit = true;
  hardware.opengl.driSupport32Bit = true;
  networking.firewall.allowedTCPPorts = [
    27036
    27037
  ];
  networking.firewall.allowedUDPPorts = [
    27031
    27036
  ];

  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";
  services.xserver.windowManager.i3 = {
    enable = true;
  };
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "scott";
  };
  services.xserver.desktopManager.default = "none";
  services.xserver.windowManager.default = "i3";

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts
  ];

  users.users.scott = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sound" "dialout" ];
  };

  system.stateVersion = "19.03";
}
