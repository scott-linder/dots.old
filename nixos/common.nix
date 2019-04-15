{ config, pkgs, ... }:

{
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/New_York";
  nixpkgs.config.allowUnfree = true;

  networking.firewall.enable = true;

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
    jetbrains.jdk
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

  programs.bash.enableCompletion = true;
  programs.ssh.startAgent = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
}
