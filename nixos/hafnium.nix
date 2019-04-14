{ config, pkgs, ... }:

{
  imports =
    [
      ./common.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Workaround for dell xps 13
  boot.kernelParams = [ "video=SVIDEO-1:d" ];

  networking.hostName = "hafnium";
  networking.wireless.enable = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.teamviewer.enable = true;

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

  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "scott";
  };
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    corefonts
  ];

  users.extraUsers.scott = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "sound" "dialout" ];
  };

  system.stateVersion = "18.09";
}
