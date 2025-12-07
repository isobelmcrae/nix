# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./apple-silicon-support
  ];

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # asahi quirks
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "kiwi";
  networking.networkmanager.enable = true;

  # uv installs python binaries to ~/.local/bin
  environment.localBinInPath = true;
  environment.variables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  # more stuff to get uv to work
  programs.nix-ld.enable = true;

  i18n.defaultLocale = "en_AU.UTF-8";
  time.timeZone = "Australia/Sydney";

  users.users.iso = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.fish;
  };

  programs.niri.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    openssl
    vim
    git
    wget
    gcc
    clang
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
  ];

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;
  system.stateVersion = "25.11";
}
